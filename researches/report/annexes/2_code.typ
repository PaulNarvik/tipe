#import "@local/typst-packages:0.1.0": *
#import "@preview/theorion:0.6.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": plot

#import cosmos.fancy: *

== Code

=== utils.hpp 

```cpp 
#pragma once

#include <cstdint>
#include <gmpxx.h>

void hour(void);

void printFactor(mpz_class &p);
void printB(uint64_t B);
```

=== utils.cpp 

```cpp 
#include "utils.hpp"
#include <iomanip>
#include <iostream>

void hour() {
  // Obtenir le temps actuel
  std::time_t now = time(nullptr);

  // Convertir en heure locale
  std::tm *localTime = std::localtime(&now);

  std::cout << std::setfill('0') << std::setw(2) << localTime->tm_hour << ":"
            << std::setfill('0') << std::setw(2) << localTime->tm_min << ":"
            << std::setfill('0') << std::setw(2) << localTime->tm_sec << " - ";
}

void printFactor(mpz_class &p) {
  hour();
  std::cout << "\033[1;32mFacteur: " << p << "\033[1;0m\n";
}

void printB(uint64_t B) {
  hour();
  std::cout << "\033[1;34mEssai pour B = " << B << "\033[1;0m\n";
}
```

=== crible.cpp

```cpp 
#include <cmath>
#include <cstdint>

uint64_t *primeArray(const uint64_t n, uint64_t *c) {
  if (n < 2) {
    *c = 0;
    return nullptr;
  }

  *c = 1;

  uint64_t p = (n + 1) / 2 - 1; // Nombre d'impair entre 3 et n
  bool *crible = new bool[p];

  uint64_t fin = ((int)sqrt(n) - 3) / 2 + 1;

  for (uint64_t i = 0; i < p; i++) {
    crible[i] = true;
  }

  for (uint64_t i = 0; i < fin; i++) {
    if (crible[i]) {
      *c += 1;
      uint64_t pas = 2 * i + 3;
      uint64_t debut = (pas * pas - 3) / 2;

      for (uint64_t j = debut; j < p; j += pas) {
        crible[j] = false;
      }
    }
  }

  // Ajouter les termes après sqrt(n)
  for (uint64_t i = fin; i < p; i++) {
    if (crible[i]) {
      *c += 1;
    }
  }

  uint64_t *premiers = new uint64_t[*c];

  premiers[0] = 2;
  uint64_t j = 1;

  for (uint64_t i = 0; i < p; i++) {
    if (crible[i]) {
      premiers[j++] = 2 * i + 3;
    }
  }

  delete[] crible;
  return premiers;
}
```

=== ellipticCurve.hpp

```cpp
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
```

=== ellipticCurve.cpp

```cpp
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
  return (4 * (this->a * this->a * this->a) + 27 * (this->b * this->b)) %
         this->p;
}

std::ostream &operator<<(std::ostream &os, ellipticCurve &E) {
  os << "Paramètres de la courbe :\n- a = " << E.a << "\n- b = " << E.b
     << "\n- p = " << E.p << "\n";
  return os;
}
```

=== ellipticPoint.hpp

```cpp 
#pragma once

#include "ellipticCurve.hpp"
#include "gmpxx.h"
#include <ostream>

struct facteurTrouve : std::exception {
  mpz_class facteur;
  facteurTrouve(mpz_class facteur) : facteur(facteur) {};
  const char *what() { return "Facteur trouvé par Lenstra"; }
};

struct ellipticPoint {
  // Membres
  mpz_class x;
  mpz_class y;
  bool infty;
  ellipticCurve *curve;

  // Constructeurs
  ellipticPoint(const mpz_class &p);
  ellipticPoint(bool infty, ellipticCurve &E);
  ellipticPoint(const mpz_class &x, const mpz_class &y, ellipticCurve &E);

  // Assignations :
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

  // Utilitaire
  void randomPointAndCurve(gmp_randclass &rng);

  // Affichage
  friend std::ostream &operator<<(std::ostream &os, ellipticPoint P);
};
```

=== ellipticPoint.cpp

```cpp 
#include "ellipticPoint.hpp"
#include "ellipticCurve.hpp"

// Constructeurs
ellipticPoint::ellipticPoint(const mpz_class &p) {
  this->x = rand() % p;
  this->y = rand() % p;
  this->infty = false;
};

ellipticPoint::ellipticPoint(bool infty, ellipticCurve &E) {
  this->x = 0;
  this->y = 0;
  this->infty = infty;
  this->curve = &E;
}

ellipticPoint::ellipticPoint(const mpz_class &x, const mpz_class &y,
                             ellipticCurve &E) {
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

// Utilitaire
void ellipticPoint::randomPointAndCurve(gmp_randclass &rng) {
  ellipticCurve *curve = this->curve;

  this->x = rng.get_z_range(curve->p);
  this->y = rng.get_z_range(curve->p);
  curve->a = rng.get_z_range(curve->p);

  curve->fixCoeffs(std::make_pair(this->x, this->y));
}

// Affichage
std::ostream &operator<<(std::ostream &os, ellipticPoint P) {
  if (P.infty)
    os << "Point à l'infini";
  else
    os << "(" << P.x << ", " << P.y << ")";
  return os;
}
```

=== factor.hpp

```cpp 
#pragma once

#include <cstdint>
#include <gmpxx.h>

struct Param {
  uint64_t maxChiffres;
  uint64_t B;
  uint64_t nbCourbesMax;
};

void trouverFacteur(const mpz_class &p, Param param, uint64_t *premiers,
                    uint64_t c, mpz_class seed);

void factoriser(mpz_class &p, mpz_class *rngs, int NB_THREADS);
```

=== factor.cpp

```cpp 
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

extern uint64_t *primeArray(const uint64_t n, uint64_t *c);

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
      }

      facteur = 1;
    }
  }

  delete[] primes;
}
```
