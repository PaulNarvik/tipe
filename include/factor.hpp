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
