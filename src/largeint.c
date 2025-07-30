#include "largeint.h"
#include <stdio.h>
#include <stdlib.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))

largeint* largeint_init(size_t size) {
  largeint* n = malloc(sizeof(largeint));
  if (n == NULL) {
    perror("Impossible d'allouer le grand entier");
    exit(EXIT_FAILURE);
  }
  n->digits = calloc(size, sizeof(uint32_t));
  if (n->digits == NULL) {
    perror("Impossible d'allouer le tableau de chiffres");
    exit(EXIT_FAILURE);
  }
  n->size = size;
  n->used = 0;
  return n;
}

void largeint_free(largeint* n) {
  free(n->digits);
  free(n);
}

void largeint_resize(largeint* n, size_t new_size) {
  uint32_t* new_digits = realloc(n->digits, new_size * sizeof(uint32_t));
  if (new_digits == NULL) {
    perror("Impossible de réallouer le tableau de chiffres");
    exit(EXIT_FAILURE);
  }
  n->digits = new_digits;
}


