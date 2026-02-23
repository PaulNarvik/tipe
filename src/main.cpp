#include "ellipticPoint.hpp"
#include <cstdint>
#include <gmp-x86_64.h>
#include <vector>
// TODO: À la fin ,trier les imports

struct Param {
  uint64_t maxChiffres;
  uint64_t B;
  uint64_t nbCourbesMax;
};

const std::vector<Param> PARAMETRES_OPTIMAUX = {
    {20, 11000, 74},       {25, 50000, 221},       {30, 250000, 453},
    {35, 1000000, 984},    {40, 3000000, 2541},    {45, 11000000, 4949},
    {50, 43000000, 8266},  {55, 110000000, 20158}, {60, 260000000, 47173},
    {65, 850000000, 77666}};

extern uint64_t *primeArray(const uint64_t n, uint64_t *c); // TODO: Un header

Param choixParametres(const mpz_class &p) {
  uint64_t chiffres = mpz_sizeinbase(p.get_mpz_t(), 10);

  for (const auto &[maxChiffres, B, nbCourbesMax] : PARAMETRES_OPTIMAUX) {
    if (chiffres < maxChiffres)
      return {maxChiffres, B, nbCourbesMax};
  }

  return PARAMETRES_OPTIMAUX.back(); // Table pas assez grande
}

mpz_class trouverFacteur(const mpz_class &p, Param param, uint64_t *premiers,
                         uint64_t c, gmp_randclass &rng) {
  uint64_t B = param.B;
  uint64_t nbCourbesMax = param.nbCourbesMax;

  // Facteurs triviaux  TODO: Vérifier si utile (dans le doute laisser)
  if (p % 2 == 0)
    return mpz_class(2);
  if (p % 3 == 0)
    return mpz_class(3);

  uint64_t nbCourbes = 0;

  mpz_class delta, pgcd;

  ellipticPoint P(p);
  ellipticCurve E(p, std::make_pair(P.x, P.y));
  P.curve = &E;

  while (nbCourbes < nbCourbesMax) { //  TODO: Changer pour concurrence
    delta = E.getDiscriminant();
    mpz_gcd(pgcd.get_mpz_t(), delta.get_mpz_t(), E.p.get_mpz_t());

    while (pgcd != 1) {
      if (pgcd < p)
        return pgcd;
      P.randomPointAndCurve(rng);
      delta = E.getDiscriminant();
      mpz_gcd(pgcd.get_mpz_t(), delta.get_mpz_t(), E.p.get_mpz_t());
    }

    try {
      for (uint64_t i = 0; i < c && premiers[i] <= B; i++) {
        uint64_t k = 1;
        uint64_t power = premiers[i];

        while (power <= B) {
          k = power;
          if (power > B / premiers[i])
            break;
          power *= premiers[i];
        }

        P = k * P;
      }
    } catch (const facteurTrouve &error) {
      mpz_gcd(pgcd.get_mpz_t(), error.facteur.get_mpz_t(), E.p.get_mpz_t());

      if (pgcd > 1 && pgcd < p)
        return pgcd;
    }

    nbCourbes++; //  TODO: À utiliser
  }

  return 1;
}

int main(void) {
  gmp_randclass rng(gmp_randinit_default);
  rng.seed(time(nullptr));

  mpz_class upperBound;
  mpz_set_str(upperBound.get_mpz_t(),
              "100000000000000000000000000000000000000000000000000", 10);
  mpz_class p = rng.get_z_range(upperBound);
  Param param = PARAMETRES_OPTIMAUX.back();
  std::cout << "À factoriser :           " << p << "\n";

  uint64_t c;
  uint64_t *premiers = primeArray(param.B, &c);

  while (!mpz_probab_prime_p(p.get_mpz_t(), 20)) {
    mpz_class facteur = trouverFacteur(p, param, premiers, c, rng);
    std::cout << "Facteur (premier) :      " << facteur << "\n";
    p /= facteur;
  }
  std::cout << "Facteur (p.s. premier) : " << p << "\n";

  delete[] premiers;
}
