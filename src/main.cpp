#include "ellipticPoint.hpp"
#include <cmath>
#include <cstdint>
#include <gmp-x86_64.h>
#include <gmpxx.h>
#include <vector>
// TODO: À la fin ,trier les imports

const std::vector<std::pair<uint64_t, uint64_t>> OPTIMAL_B = {
    {20, 11000},     {25, 50000},    {30, 250000},   {35, 1000000},
    {40, 3000000},   {45, 11000000}, {50, 43000000}, {55, 110000000},
    {60, 260000000}, {65, 850000000}

};

const mpz_class xInitial = 1;
const mpz_class yInitial = 1;

extern uint64_t *primeArray(const uint64_t n, uint64_t *c); // TODO: Un header

// TODO: Prendre result en entrée
mpz_class exponentiationRapideMod(uint64_t x, uint64_t k, mpz_class N) {
  mpz_class result = 0;
  mpz_class step = x;
  while (k > 0) {
    if (k & 1)
      result = (result + step) % N;
    k >>= 1;
    step = (step * 2) % N;
  }
  return result;
}

uint64_t choixB(const mpz_class &p) {
  uint64_t chiffres = mpz_sizeinbase(p.get_mpz_t(), 10);

  for (const auto &[maxChiffres, B] : OPTIMAL_B) {
    if (chiffres < maxChiffres)
      return B;
  }

  return OPTIMAL_B.back().second; // Table pas assez grande
}

mpz_class trouverFacteur(const mpz_class &p, uint64_t B, uint64_t *premiers) {
  // Facteurs triviaux TODO: Vérifier si utile (dans le doute laisser)
  if (p % 2 == 0)
    return mpz_class(2);
  if (p % 3 == 0)
    return mpz_class(3);

  int nbEssais = 0;
  uint64_t logB = log(B);

  mpz_class delta, pgcd;

  ellipticCurve E(
      1, p,
      std::make_pair(xInitial, yInitial)); // TODO: Courbe et point aléatoires
  ellipticPoint P(xInitial, yInitial, E);

  while (true) { // Changer pour concurrence
    E.fixCoeffs(std::make_pair(P.x, P.y));
    delta = E.getDiscriminant();
    mpz_gcd(pgcd.get_mpz_t(), delta.get_mpz_t(), E.p.get_mpz_t());

    while (pgcd != 1) {
      if (pgcd < p)
        return pgcd;
      E.fixCoeffs(std::make_pair(xInitial,
                                 yInitial)); // TODO: Courbe et point aléatoires
      delta = E.getDiscriminant();
      mpz_gcd(pgcd.get_mpz_t(), delta.get_mpz_t(), E.p.get_mpz_t());
    }

    try {
      for (uint64_t i = 0; premiers[i] <= B; i++) {
        uint64_t e = logB / log(premiers[i]);
        P = exponentiationRapideMod(premiers[i], e, p) * P; // TODO: *=
      }
    } catch (const facteurTrouve &error) {
      mpz_gcd(pgcd.get_mpz_t(), error.facteur.get_mpz_t(), E.p.get_mpz_t());

      if (pgcd > 1 && pgcd < p)
        return pgcd;
    }

    E.a = 1;    // TODO: Courbe et point aléatoires
    nbEssais++; // TODO: À utiliser ou while (true) ??????
  }

  return 1;
}

int main(void) {
  mpz_class p;
  mpz_set_str(p.get_mpz_t(), "134755010254579987971511", 10);
  uint64_t B = choixB(p);
  std::cout << "À factoriser :           " << p << "\n";

  uint64_t c; // TODO: Inutile
  uint64_t *premiers = primeArray(B, &c);

  while (!mpz_probab_prime_p(p.get_mpz_t(), 20)) {
    mpz_class facteur = trouverFacteur(p, B, premiers);
    std::cout << "Facteur (premier) :      " << facteur << "\n";
    p /= facteur;
    B = choixB(p);
  }
  std::cout << "Facteur (p.s. premier) : " << p << "\n";

  delete[] premiers;
}
