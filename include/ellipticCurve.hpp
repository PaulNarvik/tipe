#pragma once

#include <gmpxx.h>
#include <iostream>
#include <ostream>
#include <utility>

struct ellipticCurve {
  mpz_class a;
  mpz_class b;
  mpz_class p;

  ellipticCurve(const mpz_class &a, const mpz_class &p);

  void fixCoeffs(const std::pair<mpz_class, mpz_class> &point);

  friend std::ostream &operator<<(std::ostream &os, ellipticCurve &E);
};
