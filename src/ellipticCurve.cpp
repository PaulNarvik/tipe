#include "ellipticCurve.hpp"
#include <gmpxx.h>
#include <utility>

ellipticCurve::ellipticCurve(const mpz_class &a, const mpz_class &p) {
  this->a = a;
  this->p = p;
}

void ellipticCurve::fixCoeffs(const std::pair<mpz_class, mpz_class> &P) {
  mpz_class x = P.first;
  mpz_class y = P.second;
  this->b = (y * y) - (x * x * x) - (this->a * x);
}
