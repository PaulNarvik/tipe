#include "ellipticCurve.hpp"
#include "ellipticPoint.hpp"
#include <gmp-x86_64.h>
#include <gmpxx.h>
#include <iostream>

const int BIncr = 1;
const int aIncr = 1;
const int nbEssaisMax = 50;
const int xInitial = 1;
const int yInitial = 1;

mpz_class trouverFacteur(mpz_class p, mpz_class B) {
  // Facteurs triviaux
  if (p % 2 == 0)
    return 2;
  if (p % 3 == 0)
    return 3;

  int nbEssais = 0;

  mpz_class Bsub = B - 1;
  mpz_class k;
  mpz_lcm(k.get_mpz_t(), B.get_mpz_t(), Bsub.get_mpz_t());
}

int main(void) {
  ellipticCurve E(1, 7);
  std::cout << E.a << ", " << E.b << ", " << E.p << "\n";
  // ellipticPoint P(1, 1, E);
  // ellipticPoint Q = P + P;
}
