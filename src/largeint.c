#include "largeint.h"
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define BASE ((uint64_t)1 << 32)

largeint *largeint_init(size_t size) {
  largeint *ptr = malloc(sizeof(largeint));
  if (ptr == NULL) {
    perror("Impossible d'allouer le grand entier");
    exit(EXIT_FAILURE);
  }

  ptr->digits = malloc(size * sizeof(uint32_t));
  if (ptr->digits == NULL) {
    perror("Impossible d'allouer le tableau de chiffres");
    exit(EXIT_FAILURE);
  }

  ptr->size = size;
  ptr->used = 0;

  return ptr;
}

// void largeint_load(largeint *ptr, char *val) {}

void largeint_load_base(largeint *ptr, uint32_t val) { // Disparaitra à terme
  ptr->digits[0] = val;
  ptr->used = 1;
}

void largeint_resize(largeint *ptr, size_t new_size) {
  uint32_t *new_digits = realloc(ptr->digits, new_size * sizeof(uint32_t));
  if (new_digits == NULL) {
    perror("Impossible de réallouer le tableau de chiffres");
    exit(EXIT_FAILURE);
  }
  ptr->digits = new_digits;
  ptr->used = MIN(ptr->used, new_size);
}

/**
 * @brief Actualise le champ used et réduit la taille du grand entier si
 * nécessaire.
 * @param ptr Le pointeur vers l'entier à actualiser.
 * @param start Le point de départ pour vérifier quels chiffres sont utilisés.
 * @pre Le pointeur est non nul.
 */
void largeint_update(largeint *ptr, size_t start) {
  size_t i = start + 1;
  while (i > 0 && ptr->digits[i - 1] != 0)
    i--;
  ptr->size = i - 1;

  if (ptr->used * 4 < ptr->size) {
    largeint_resize(ptr, ptr->used * 2);
  }
}

void largeint_free(largeint *ptr) {
  free(ptr->digits);
  free(ptr);
}

// void largeint_print(largeint *ptr) {}

void largeint_print_base(largeint *ptr) {
  for (size_t i = ptr->used; i > 1; i--) {
    printf("%d, ", ptr->digits[i - 1]);
  }
  printf("%d\n", ptr->digits[0]);
}

int8_t largeint_abs_comp(largeint *ptr1, largeint *ptr2) {
  if (ptr1->used > ptr2->used)
    return 1;
  if (ptr1->used < ptr2->used)
    return -1;

  for (size_t i = ptr1->used + 1; i > 0; i--)
    if (ptr1->digits[i - 1] != ptr2->digits[i - 1])
      return ptr1->digits[i - 1] > ptr2->digits[i - 1] ? 1 : -1;

  return 0;
}
/**
 * @brief Soustrait deux grands entiers sans prendre en compte les signes.
 * @param result Le pointeur derrière lequel stocker le résultat.
 * @param ptr1 Le pointeur du premier grand entier.
 * @param ptr2 Le pointeur du deuxième grand entier, que l'on soustrait.
 * @pre Le premier entier est plus grand que le deuxième.
 */
void largeint_abs_sub(largeint *result, largeint *ptr1, largeint *ptr2) {
  size_t needed = ptr1->used;
  uint64_t borrow = 0;

  for (size_t i = 0; i < needed; i++) {
    int64_t diff = ptr1->digits[i] - borrow;
    if (i < ptr2->used)
      diff -= ptr2->digits[i];

    if (diff < 0) {
      borrow = 1;
      diff += BASE;
    } else
      borrow = 0;

    result->digits[i] = diff;
  }
}

void largeint_add(largeint *result, largeint *ptr1, largeint *ptr2) {
  size_t needed = MAX(ptr1->used, ptr2->used);
  if (needed >= result->size)
    largeint_resize(result, needed * 2);

  if (ptr1->sign == ptr2->sign) {
    uint64_t carry = 0;
    for (size_t i = 0; i < needed; i++) {
      uint64_t sum = carry;
      if (i < ptr1->used)
        sum += ptr1->digits[i];
      if (i < ptr2->used)
        sum += ptr2->digits[i];

      result->digits[i] = (uint32_t)(sum & 0xFFFFFFFF);
      carry = sum >> 32;
    }
    result->digits[needed] = (uint32_t)carry;
    result->sign = ptr1->sign;
  }

  else {
    int8_t cmp = largeint_abs_comp(ptr1, ptr2);
    largeint *larger = cmp >= 0 ? ptr1 : ptr2;
    largeint *smaller = cmp >= 0 ? ptr2 : ptr1;

    largeint_abs_sub(result, larger, smaller);
    result->sign = larger->sign;
  }

  largeint_update(result, needed);
}

void largeint_sub(largeint *result, largeint *ptr1, largeint *ptr2) {
  ptr2->sign *= -1;
  largeint_add(result, ptr1, ptr2);
  ptr2->sign *= -1;
}

// void largeint_multiply(largeint *result, largeint *ptr1, largeint *ptr2) {}
