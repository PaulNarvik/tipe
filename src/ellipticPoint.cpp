#include "ellipticPoint.hpp"
#include <gmpxx.h>
#include <iostream>
#include <ostream>

// Constructeurs
ellipticPoint::ellipticPoint(bool infty, const ellipticCurve &E) {
  this->x = 0;
  this->y = 0;
  this->infty = infty;
  this->curve = &E;
}

ellipticPoint::ellipticPoint(const mpz_class &x, const mpz_class &y,
                             const ellipticCurve &E) {
  this->x = x;
  this->y = y;
  this->infty = false;
  this->curve = &E;
}

// Assignations :  Ajouter += etc ????? => Remplacer + ?????
ellipticPoint::ellipticPoint(const ellipticPoint &) = default;
ellipticPoint &ellipticPoint::operator=(const ellipticPoint &) = default;

// Egalite
bool ellipticPoint::operator==(const ellipticPoint &P) const {
  return (infty && P.infty) || (x == P.x && y == P.y);
};
bool ellipticPoint::operator!=(const ellipticPoint &P) const {
  return !(*this == P);
}

// Calculs
ellipticPoint operator+(const ellipticPoint &P1, const ellipticPoint &P2) {
  if (P1.curve != P2.curve)
    throw std::runtime_error("Courbes différentes");

  // Cas d'un point à l'infini
  if (P1.infty)
    return P2;
  if (P2.infty)
    return P1;

  if ((P1.x == P2.x) && ((P1.y + P2.y) % P1.curve->p == 0)) // Points opposés
    return ellipticPoint(true, *P1.curve);
  else { // Supprimer duplicatas de code ici !!!!!
    mpz_class s;
    bool result;
    mpz_class pgcd = 1;
    if (P1 == P2) { // Un seul point
      mpz_class num =
          3 * P1.x * P1.x + P1.curve->a; // Modulo sur ces deux lignes ?????
      mpz_class denom = 2 * P1.y;

      mpz_class inv;
      result = mpz_invert(
          inv.get_mpz_t(), denom.get_mpz_t(),
          P1.curve->p.get_mpz_t()); // si result = 0, pas inversible !!!!!
      if (!result)
        mpz_gcd(pgcd.get_mpz_t(), denom.get_mpz_t(), P1.curve->p.get_mpz_t());
      else
        s = (num * inv) % P1.curve->p;
    } else { // Deux points n'ayant pas même abscisse
      mpz_class num = P2.y - P1.y;
      mpz_class denom = P2.x - P1.x;

      mpz_class inv;
      result = mpz_invert(inv.get_mpz_t(), denom.get_mpz_t(),
                          P1.curve->p.get_mpz_t()); // Même remarque !!!!!
      if (!result)
        mpz_gcd(pgcd.get_mpz_t(), denom.get_mpz_t(), P1.curve->p.get_mpz_t());
      else
        s = (num * inv) % P1.curve->p;
    }

    if (1 < pgcd && P1.curve->p > pgcd) {
      throw facteurTrouve(pgcd);
    } else {
      // Changer de courbe !!!!!
    }

    mpz_class x = (s * s - P1.x - P2.x) % P1.curve->p;
    mpz_class y = (s * (P1.x - x) - P1.y) % P1.curve->p;
    if (x < 0)
      x += P1.curve->p;
    if (y < 0)
      y += P1.curve->p;
    return ellipticPoint(x, y, *P1.curve);
  }
};

ellipticPoint operator*(int k, const ellipticPoint &P) {
  ellipticPoint Q = P;
  ellipticPoint R = ellipticPoint(true, *P.curve);
  while (k > 0) {
    if (k & 1) { // k is odd
      R = R + Q;
    }
    Q = Q + Q;
    k >>= 1;
  }
  return R;
}

ellipticPoint operator*(mpz_class k, const ellipticPoint &P) {
  ellipticPoint Q = P;
  ellipticPoint R = ellipticPoint(true, *P.curve);
  while (k > 0) {
    if (mpz_tstbit(k.get_mpz_t(), 0)) { // k is odd
      R = R + Q;
    }
    Q = Q + Q;
    k >>= 1;
  }
  return R;
}

// Affichage
std::ostream &operator<<(std::ostream &os, ellipticPoint P) {
  if (P.infty)
    os << "Point à l'infini";
  else
    os << "(" << P.x << ", " << P.y << ")";
  return os;
}
