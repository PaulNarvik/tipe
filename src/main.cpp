#include "ellipticCurve.hpp"
#include "ellipticPoint.hpp"

const int BIncr = 1;
const int aIncr = 30;
const int nbEssaisMax = 50;
const mpz_class xInitial = 1;
const mpz_class yInitial = 1;

extern int *primeArray(int n, int *c);

mpz_class calck(mpz_class &B) {
  mpz_class k;
  mpz_class Bsub = B - 1;
  mpz_lcm(k.get_mpz_t(), B.get_mpz_t(), Bsub.get_mpz_t());
  return k;
}

mpz_class trouverFacteur(mpz_class p, mpz_class B) {
  // Facteurs triviaux
  if (p % 2 == 0)
    return mpz_class(2);
  if (p % 3 == 0)
    return mpz_class(3);

  int nbEssais = 0;
  bool nouvelleCourbe = false;

  mpz_class delta, pgcd;
  mpz_class k = calck(B);

  ellipticCurve E(1, p, std::make_pair(xInitial, yInitial));
  ellipticPoint P(xInitial, yInitial, E);
  ellipticPoint Q;

  while (true) { // Changer pour concurrence
    E.fixCoeffs(std::make_pair(P.x, P.y));
    delta = E.getDiscriminant();
    mpz_gcd(pgcd.get_mpz_t(), delta.get_mpz_t(), E.p.get_mpz_t());

    while (pgcd != 1) {
      if (pgcd < p)
        return pgcd;
      E.a += aIncr;
      E.fixCoeffs(std::make_pair(xInitial, yInitial));
      delta = E.getDiscriminant();
      mpz_gcd(pgcd.get_mpz_t(), delta.get_mpz_t(), E.p.get_mpz_t());
    }

    if (nbEssais > nbEssaisMax)
      nouvelleCourbe = true; // renvoie std::optionnal plus tard

    try {
      Q = k * P;
    } catch (const facteurTrouve &facteur) {
      mpz_gcd(pgcd.get_mpz_t(), facteur.facteur.get_mpz_t(), E.p.get_mpz_t());

      if (pgcd > 1 && pgcd < p)
        return pgcd;
    }

    if (nouvelleCourbe) {
      E.a = 1;
      nbEssais = 0;

      do
        B += BIncr;
      while (k == calck(B)); // On change B qui est passé en argument, renvoyer
                             // et rappeler avec le tampon
      k = calck(B);
    } else {
      E.a += aIncr;
      nbEssais++;
    }
  }

  return 1;
}

int main(void) {
  mpz_class p, B; // B en uint64_t
  mpz_set_str(p.get_mpz_t(), "134755010254579987971511", 10);
  mpz_set_str(B.get_mpz_t(), "367091132971", 10);
  std::cout << "À factoriser :           " << p << "\n";

  while (!mpz_probab_prime_p(p.get_mpz_t(), 20)) {
    mpz_class facteur = trouverFacteur(p, B);
    std::cout << "Facteur (premier) :      " << facteur << "\n";
    p /= facteur;
  }
  std::cout << "Facteur (p.s. premier) : " << p << "\n";
}
