#include <gmpxx.h>

#include <chrono>
#include <iomanip>
#include <iostream>
#include <map>
#include <vector>

using namespace std;
using namespace std::chrono;

// Factorisation naïve par divisions successives
map<mpz_class, int> naive_factorization(mpz_class n) {
  map<mpz_class, int> factors;

  // Gestion du facteur 2
  while (n % 2 == 0) {
    factors[2]++;
    n /= 2;
  }

  // Diviseurs impairs
  mpz_class d = 3;

  // On teste jusqu'à sqrt(n)
  while (d * d <= n) {
    while (n % d == 0) {
      factors[d]++;
      n /= d;
    }

    d += 2;
  }

  // S'il reste un facteur premier
  if (n > 1) {
    factors[n]++;
  }

  return factors;
}

void print_factorization(const map<mpz_class, int> &factors) {
  bool first = true;

  for (const auto &[p, e] : factors) {
    if (!first)
      cout << " * ";

    cout << p;

    if (e > 1)
      cout << "^" << e;

    first = false;
  }

  cout << '\n';
}

int main() {
  mpz_class n;

  cout << "Entier à factoriser : ";
  cin >> n;

  auto start = high_resolution_clock::now();

  auto factors = naive_factorization(n);

  auto end = high_resolution_clock::now();

  duration<double> elapsed = end - start;

  cout << "\nFactorisation :\n";
  print_factorization(factors);

  cout << fixed << setprecision(6);
  cout << "\nTemps d'exécution : " << elapsed.count() << " secondes\n";

  return 0;
}
