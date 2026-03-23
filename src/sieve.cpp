#include <cmath>
#include <cstdint>
#include <sys/types.h>

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

  // TODO: Séparer en deux à cet endroit ? Header vs extern ?
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
