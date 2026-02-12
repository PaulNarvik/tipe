#pragma once

#include "ellipticCurve.hpp"
#include "gmpxx.h"
#include <ostream>

struct facteurTrouve : std::exception {
  mpz_class facteur;
  facteurTrouve(mpz_class facteur) : facteur(facteur) {};
  const char *what() { return "Facteur trouvé par Lenstra"; }
};

struct ellipticPoint { // Encapsuler plus tard ?????
  // Membres
  mpz_class x;
  mpz_class y;
  bool infty;
  const ellipticCurve *curve;

  // Constructeurs
  ellipticPoint(bool infty, const ellipticCurve &E);
  ellipticPoint(const mpz_class &x, const mpz_class &y, const ellipticCurve &E);

  // Assignations :  Ajouter += etc ?
  ellipticPoint(const ellipticPoint &);
  ellipticPoint &operator=(const ellipticPoint &);

  // Egalite
  bool operator==(const ellipticPoint &P) const;
  bool operator!=(const ellipticPoint &P) const;

  // Calculs
  friend ellipticPoint operator+(const ellipticPoint &P1,
                                 const ellipticPoint &P2);
  friend ellipticPoint operator*(int k, const ellipticPoint &P);
  friend ellipticPoint operator*(mpz_class k, const ellipticPoint &P);

  // Affichage
  friend std::ostream &operator<<(std::ostream &os, ellipticPoint P);
};
