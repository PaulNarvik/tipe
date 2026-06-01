#include "factor.hpp"
#include <chrono>
#include <ctime>
#include <iomanip>
#include <iostream>
// TODO: À la fin ,trier les imports

const int NB_THREADS = 16;

int main(void) {
  // Initialisation du hasard global
  gmp_randclass rng(gmp_randinit_default);
  rng.seed(time(nullptr));

  // Initialisation du hasard par thread
  mpz_class *rngs = new mpz_class[NB_THREADS];
  for (int i = 0; i < NB_THREADS; i++) {
    rngs[i] = rng.get_z_bits(128);
  }

  // Taille max de p
  mpz_class upperBound = 1;
  int exponent = 50;
  for (int i = 0; i < exponent; i++)
    upperBound *= 10;
  mpz_class p;
  mpz_set_str(p.get_mpz_t(),
              "7099074735650163361090334063849287869508897030027526772787", 10);

  // Entier à factoriser
  // mpz_class p = rng.get_z_range(upperBound);

  auto start = std::chrono::high_resolution_clock::now();
  factoriser(p, rngs, NB_THREADS);
  auto end = std::chrono::high_resolution_clock::now();
  std::chrono::duration<double> elapsed = end - start;
  std::cout << std::fixed << std::setprecision(6);
  std::cout << "\nTemps d'exécution : " << elapsed.count() << " secondes\n";
}
