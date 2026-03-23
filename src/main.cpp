#include "ellipticPoint.hpp"
#include <cmath>
#include <cstdint>
#include <ctime>
#include <gmp-x86_64.h>
#include <iomanip>
#include <vector>
// TODO: À la fin ,trier les imports

struct Param {
  uint64_t maxChiffres;
  uint64_t B;
  uint64_t nbCourbesMax;
};
struct Arg {
  uint64_t indice;
  uint64_t B;
  uint64_t nbCourbesMax;
};

void hour() {
  // Obtenir le temps actuel
  std::time_t now = std::time(nullptr);

  // Convertir en heure locale
  std::tm *localTime = std::localtime(&now);

  std::cout << std::setfill('0') << std::setw(2) << localTime->tm_hour << ":"
            << std::setfill('0') << std::setw(2) << localTime->tm_min << ":"
            << std::setfill('0') << std::setw(2) << localTime->tm_sec << " - ";
}

const std::vector<Param> PARAMETRES_OPTIMAUX = {
    {20, 11000, 74},       {25, 50000, 221},       {30, 250000, 453},
    {35, 1000000, 984},    {40, 3000000, 2541},    {45, 11000000, 4949},
    {50, 43000000, 8266},  {55, 110000000, 20158}, {60, 260000000, 47173},
    {65, 850000000, 77666}};

extern uint64_t *primeArray(const uint64_t n, uint64_t *c); // TODO: Un header

Arg choixParametres(const mpz_class &p) {
  mpz_class racine;
  mpz_sqrt(racine.get_mpz_t(), p.get_mpz_t());
  uint64_t chiffres = mpz_sizeinbase(racine.get_mpz_t(), 10); // Pour un facteur

  for (uint64_t i = 0; i < PARAMETRES_OPTIMAUX.size(); i++) {
    Param param = PARAMETRES_OPTIMAUX[i];
    if (chiffres < param.maxChiffres)
      return {i, param.B, param.nbCourbesMax};
  }

  return {PARAMETRES_OPTIMAUX.size(), 0, 0}; // Tableau pas assez grand
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

  while (nbCourbes <
         nbCourbesMax) { //  TODO: Changer pour concurrence + plusieurs rng
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
        return pgcd;
    }

    nbCourbes++;
  }

  return 1;
}

int main(void) {
  gmp_randclass rng(gmp_randinit_default);
  rng.seed(time(nullptr));

  // Taille max de p
  mpz_class upperBound;
  mpz_set_str(upperBound.get_mpz_t(),
              "10000000000000000000000000000000000000000000000", 10);

  // Entier à factoriser
  mpz_class p = rng.get_z_range(upperBound);
  // mpz_set_str(p.get_mpz_t(),
  //             "2152741102718889701896015201312825429257773588845675980170497676"
  //             "7781331452188591356730110597734910596024979071115852143020793146"
  //             "65202840140619946994927570407753",
  //             10);
  hour();
  std::cout << "\033[1;32mÀ factoriser: " << p << "\033[0m\n\n";

  // Initialisation des paramètres
  Param param = PARAMETRES_OPTIMAUX.front(); //  TODO: Front au lieu de back
  uint64_t i = 1;

  // Crible
  uint64_t c;
  uint64_t *premiers = primeArray(param.B, &c);
  hour();
  std::cout << "\033[1;34mCrible généré pour B = " << param.B << "\033[1;0m\n";

  //  TODO: Ne pas regénérer tout le tableau et garder la taille max si je
  //  décide de rétrécir
  while (!mpz_probab_prime_p(p.get_mpz_t(), 20)) {
    mpz_class facteur = trouverFacteur(p, param, premiers, c, rng);
    if (facteur == 1) {
      if (i < PARAMETRES_OPTIMAUX.size()) {
        param = PARAMETRES_OPTIMAUX[i++];
        premiers = primeArray(param.B, &c);
      }

      std::cout << "\n";
      hour();
      std::cout << "\033[1;34mNouvel essai pour B = " << param.B
                << "\033[1;0m\n";
    } else {
      hour();
      std::cout << "\033[1;32mFacteur: " << facteur << "\033[1;0m\n";
      p /= facteur;
      // param = choixParametres(p);
    }
  }
  hour();
  std::cout << "\033[1;32mFacteur: " << p << "\033[1;0m\n";

  delete[] premiers;
}
