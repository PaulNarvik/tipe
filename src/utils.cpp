#include "utils.hpp"
#include <iomanip> // For filling time print
#include <iostream>

void hour() {
  // Obtenir le temps actuel
  std::time_t now = time(nullptr);

  // Convertir en heure locale
  std::tm *localTime = std::localtime(&now);

  std::cout << std::setfill('0') << std::setw(2) << localTime->tm_hour << ":"
            << std::setfill('0') << std::setw(2) << localTime->tm_min << ":"
            << std::setfill('0') << std::setw(2) << localTime->tm_sec << " - ";
}

void printFactor(mpz_class &p) {
  hour();
  std::cout << "\033[1;32mFacteur: " << p << "\033[1;0m\n";
}

void printB(uint64_t B) {
  hour();
  std::cout << "\033[1;34mEssai pour B = " << B << "\033[1;0m\n";
}
