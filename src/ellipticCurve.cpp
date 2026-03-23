#include "ellipticCurve.hpp"

ellipticCurve::ellipticCurve(const mpz_class &p,
                             const std::pair<mpz_class, mpz_class> &P) {
  this->a = rand() % p;
  this->p = p;
  fixCoeffs(P);
}

void ellipticCurve::fixCoeffs(const std::pair<mpz_class, mpz_class> &P) {
  mpz_class x = P.first;
  mpz_class y = P.second;
  this->b = ((y * y) - (x * x * x) - (this->a * x)) % this->p;
}

mpz_class ellipticCurve::getDiscriminant() {
  return 4 * (this->a * this->a * this->a) + 27 * (this->b * this->b);
}

std::ostream &operator<<(std::ostream &os, ellipticCurve &E) {
  os << "Paramètres de la courbe :\n- a = " << E.a << "\n- b = " << E.b
     << "\n- p = " << E.p << "\n";
  return os;
}
