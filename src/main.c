#include "largeint.h"
#include <stdint.h>
#include <stdlib.h>

int main() {
  largeint *n = largeint_init(10);
  largeint_load_base(n, 1000);
  largeint_print_base(n);
  largeint_free(n);
  return EXIT_SUCCESS;
}
