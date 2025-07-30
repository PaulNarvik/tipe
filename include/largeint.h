/**
 * @file largeint.h
 * @brief Définitions pour les grands entiers nécessaires à la cryptographie sur les courbes elliptiques.
 */

#ifndef LARGEINT_H
#define LARGEINT_H

#include <stdint.h>
#include <stddef.h>

/**
 * @struct largeint
 * @brief Représente un grand entier à l'aide d'un tableau.
 * @param digits Tableau des chiffres du grand entier en base 2^32.
 * @param size Nombre de chiffres utilisés par le grand entier.
 * @param used Rang du dernier chiffre utilisé.
 * @note Cette structure est implémentée comme un tableau dynamique, en particulier, aucune condtion n'est donnée sur le contenu des cellules dont l'indice est supérieur à celle du dernier chiffre utilisé.
 */
typedef struct {
  uint32_t* digits;
  size_t size;
  size_t used;
} largeint;

/**
 * @defgroup largeint_ops Opérations sur les grands entiers
 * @brief Fonctions pour manipuler les grands entiers.
 * @{
 */

/**
 * @brief Renvoie un pointeur vers un grand entier de la taille voulue.
 * @param size Nombre de chiffres initial du grand entier.
 * @return Un pointeur vers le grand entier.
 */
largeint* largeint_init(size_t size);

/**
 * @brief Libère toute la mémoire occupée par le grand entier.
 * @param n Le pointeur vers le grand entier.
 * @pre Le pointeur est non nul.
 */
void largeint_free(largeint* n);

/**
 * @brief Redimensionne le grand entier à la taille donné.
 * @param n Le pointeur vers le grand entier à redimensionner.
 * @param new_size La nouvelle taille de l'entier.
 * @pre La nouvelle taille est supérieure au nombre de chiffres utilisés, pour éviter toute perte d'informations.
 * @warning Dans le cas où la précondition n'est pas respectée, les chiffres restants seront tronqués.
 */
void largeint_resize(largeint* n, size_t new_size);

/**
 * @brief Additionne deux grands entiers et place le résultat derrière le pointeur donné.
 * @param result Le pointeur derrière lequel stocker la somme.
 * @param n Le pointeur vers le premier grand entier à sommer.
 * @param m Le pointeur vers le deuxième grand entier à sommer.
 * @pre Le pointeur `result` correspond à une zone mémoire valide.
 * @note La valeur précédemment derrière le pointeur `result` est écrasée.
 */
void largeint_add(largeint* result, largeint* n, largeint* m);

/**
 * @brief Multiplie deux grands entiers et place le résultat derrière le pointeur donné.
 * @param result Le pointeur derrière lequel stocker le produit.
 * @param n Le pointeur vers le premier grand entier à multiplier.
 * @param m Le pointeur vers le deuxième grand entier à multiplier.
 * @pre Le pointeur result correspond à une zone mémoire valide.
 * @note La valeur précédente derrière le pointeur `result` est écrasée.
 */
void largeint_multiply(largeint* result);

/** @} */

#endif
