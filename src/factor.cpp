#include "factor.hpp"
#include "ellipticPoint.hpp"
#include "utils.hpp"

#include <cmath>
#include <cstdint>
#include <gmpxx.h>
#include <mutex>
#include <queue>
#include <thread>
#include <vector>

extern uint64_t *primeArray(const uint64_t n, uint64_t *c); // TODO: Un header ?

const std::vector<Param> PARAMETRES_OPTIMAUX = {
    {20, 11000, 74},       {25, 50000, 221},       {30, 250000, 453},
    {35, 1000000, 984},    {40, 3000000, 2541},    {45, 11000000, 4949},
    {50, 43000000, 8266},  {55, 110000000, 20158}, {60, 260000000, 47173},
    {65, 850000000, 77666}};

mpz_class facteur = 1;
uint64_t nbCourbes = 0;
std::mutex verrou;

void setFacteur(mpz_class &p) {
  verrou.lock();
  facteur = p;
  verrou.unlock();
}

void trouverFacteur(const mpz_class &p, Param param, uint64_t *premiers,
                    uint64_t c, mpz_class seed) {
  gmp_randclass rng(gmp_randinit_default);
  rng.seed(seed ^ time(NULL));

  uint64_t B = param.B;
  uint64_t nbCourbesMax = param.nbCourbesMax;

  mpz_class delta, pgcd;

  ellipticPoint P(p);
  ellipticCurve E(p, std::make_pair(P.x, P.y));
  P.curve = &E;

  bool ok = true;

  while (ok) {
    delta = E.getDiscriminant();
    mpz_gcd(pgcd.get_mpz_t(), delta.get_mpz_t(), E.p.get_mpz_t());

    while (pgcd != 1) {
      if (pgcd < p)
        setFacteur(pgcd);
      P.randomPointAndCurve(rng);
      delta = E.getDiscriminant();
      mpz_gcd(pgcd.get_mpz_t(), delta.get_mpz_t(), E.p.get_mpz_t());
    }

    try {
      for (uint64_t i = 0; i < c && premiers[i] <= B; i++) {
        mpz_class e = log(B) / log(premiers[i]);
        mpz_class result;
        mpz_class premier = premiers[i];
        mpz_powm(result.get_mpz_t(), premier.get_mpz_t(), e.get_mpz_t(),
                 p.get_mpz_t());

        P = result * P;
      }
    } catch (const facteurTrouve &error) {
      mpz_gcd(pgcd.get_mpz_t(), error.facteur.get_mpz_t(), E.p.get_mpz_t());

      if (pgcd > 1 && pgcd < p)
        setFacteur(pgcd);
    }

    verrou.lock();
    nbCourbes++;
    ok = nbCourbes < nbCourbesMax && facteur == 1;
    verrou.unlock();
  }
}

void factoriser(mpz_class &p, mpz_class *rngs, int NB_THREADS) {
  // Affichage initial
  hour();
  std::cout << "\033[1;32mÀ factoriser: " << p << "\033[0m\n\n";

  // Threads
  std::thread *threads = new std::thread[NB_THREADS];

  // Initialisation des paramètres
  Param param = PARAMETRES_OPTIMAUX.front();
  uint64_t currentParametre = 0;

  // Crible initial
  uint64_t c;
  uint64_t *primes = primeArray(param.B, &c);
  printB(param.B);

  mpz_class n = 0;
  while (p % 2 == 0) {
    n = 2;
    printFactor(n);
    p /= 2;
  }
  while (p % 3 == 0) {
    n = 3;
    printFactor(n);
    p /= 3;
  }

  // File à factoriser
  std::queue<mpz_class> remaining;
  remaining.push(p);

  while (!remaining.empty()) {
    mpz_class p = remaining.front();
    if (mpz_probab_prime_p(p.get_mpz_t(), 20)) {
      remaining.pop();
      printFactor(p);
    } else {
      for (int i = 0; i < NB_THREADS; i++) {
        threads[i] = std::thread(trouverFacteur, p, param, primes, c, rngs[i]);
      }
      for (int i = 0; i < NB_THREADS; i++) {
        threads[i].join();
      }

      if (facteur == 1) {
        if (currentParametre < PARAMETRES_OPTIMAUX.size()) {
          currentParametre++;
          param = PARAMETRES_OPTIMAUX[currentParametre];
          primes = primeArray(param.B, &c);
        }

        std::cout << "\n";
        printB(param.B);
      } else {
        remaining.pop();
        remaining.push(facteur);
        remaining.push(p / facteur);
        // param = choixParametres(p);
      }

      facteur = 1;
    }
  }

  delete[] primes;
}
