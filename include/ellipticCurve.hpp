#pragma once

#include <gmpxx.h>
#include <iostream>
#include <ostream>

struct ellipticCurve {
  mpz_class a;
  mpz_class b;
  mpz_class p;

  ellipticCurve(const mpz_class &p, const std::pair<mpz_class, mpz_class> &P);

  void fixCoeffs(const std::pair<mpz_class, mpz_class> &P);
  mpz_class getDiscriminant();

  friend std::ostream &operator<<(std::ostream &os, ellipticCurve &E);
};
