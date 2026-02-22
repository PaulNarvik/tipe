#include <cmath>

int *primeArray(int n, int *c) { // c = 1 initialement
  if (n < 2) {
    *c = 0;
    return nullptr;
  }

  *c = 1;

  int p = (n + 1) / 2 - 1; // Nombre d'impair entre 3 et n
  bool *crible = new bool[p];

  int fin = ((int)sqrt(n) - 3) / 2 + 1;

  for (int i = 0; i < p; i++) {
    crible[i] = true;
  }

  for (int i = 0; i < fin; i++) {
    if (crible[i]) {
      *c += 1;
      int pas = 2 * i + 3;
      int debut = (pas * pas - 3) / 2;

      for (int j = debut; j < p; j += pas) {
        crible[j] = false;
      }
    }
  }

  // Ajouter les termes après sqrt(n)
  for (int i = fin; i < p; i++) {
    if (crible[i]) {
      *c += 1;
    }
  }

  // TODO: Séparer en deux à cet endroit ? Header vs extern ?
  int *premiers = new int[*c];

  premiers[0] = 2;
  int j = 1;

  for (int i = 0; i < p; i++) {
    if (crible[i]) {
      premiers[j++] = 2 * i + 3;
    }
  }

  delete[] crible;
  return premiers;
}
