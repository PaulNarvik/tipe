/**
 * @file largeint.h
 * @brief Définitions pour les grands entiers nécessaires à la cryptographie sur
 * les courbes elliptiques.
 */

#ifndef LARGEINT_H
#define LARGEINT_H

#include <stddef.h>
#include <stdint.h>

/**
 * @struct largeint
 * @brief Représente un grand entier à l'aide d'un tableau.
 * @param digits Tableau des chiffres du grand entier en base 2^32.
 * @param size Nombre de chiffres utilisés par le grand entier.
 * @param used Rang du dernier chiffre utilisé.
 * @param sign Le signe du grand entier, 1 pour positif, -1 pour négatif.
 * @note Cette structure est implémentée comme un tableau dynamique, en
 * particulier, aucune condtion n'est donnée sur le contenu des cellules dont
 * l'indice est supérieur à celle du dernier chiffre utilisé.
 */
typedef struct {
  uint32_t *digits;
  size_t size;
  size_t used;
  uint8_t sign;
} largeint;

/**
 * @defgroup largeint_func Fonctions sur les grands entiers
 * @brief Fonctions pour manipuler les grands entiers.
 * @{
 */

/**
 * @defgroup largeint_func_mem Fonctions liées à la mémoire
 * @brief Fonctions pour manipuler la mémoire liée aux grands entiers.
 * @ingroup largeint_func
 * @{
 */

/**
 * @brief Renvoie un pointeur vers un grand entier de la taille voulue.
 * @param size Nombre de chiffres initial du grand entier.
 * @return Un pointeur vers le grand entier.
 */
largeint *largeint_init(size_t size);

/**
 * @brief Charge un entier de taille arbitraire en base 10 sous forme de chaîne
 * de caractères dans le grand entier.
 * @param ptr Le pointeur vers le grand entier.
 * @param val La chaîne de caractères.
 * @pre Le pointeur est non nul.
 * @note La valeur précédemment derrière le pointeur `ptr` est écrasée.
 */
void largeint_load(largeint *ptr, char *val);

/**
 * @brief Charge un `uint32_t` dans le grand entier.
 * @param ptr Le pointeur vers le grand entier.
 * @param val L'entier à charger.
 * @pre Le pointeur est non nul.
 * @pre La taille du grand entier est non nul.
 * @note La valeur précédemment derrière le pointeur `ptr` est écrasée.
 */
void largeint_load_base(largeint *ptr, uint32_t val);

/**
 * @brief Redimensionne le grand entier à la taille donné.
 * @param ptr Le pointeur vers le grand entier à redimensionner.
 * @param new_size La nouvelle taille de l'entier.
 * @pre La nouvelle taille est supérieure au nombre de chiffres utilisés, pour
 * éviter toute perte d'informations.
 * @warning Dans le cas où la précondition n'est pas respectée, les chiffres
 * restants seront tronqués.
 */
void largeint_resize(largeint *ptr, size_t new_size);

/**
 * @brief Libère toute la mémoire occupée par le grand entier.
 * @param ptr Le pointeur vers le grand entier.
 * @pre Le pointeur est non nul.
 */
void largeint_free(largeint *ptr);

/** @} */

/**
 * @defgroup largeint_func_aff Fonctions liées à l'affichage
 * @brief Fonctions pour aficher de grands entiers.
 * @ingroup largeint_func
 * @{
 */

/**
 * @brief Affiche un grand entier en base 10.
 * @param ptr Le pointeur vers le grand entier.
 * @pre Le pointeur est non nul.
 */
void largeint_print(largeint *ptr);

/**
 * @brief Affiche un grand entier en base 2^32.
 * @param ptr Le pointeur vers le grand entier.
 * @pre Le pointeur est non nul.
 */
void largeint_print_base(largeint *ptr);

/** @} */

/**
 * @brief Additionne deux grands entiers et place le résultat derrière le
pointeur donné.
 * @param result Le pointeur derrière lequel stocker la somme.
 * @param ptr1 Le pointeur vers le premier grand entier à sommer.
 * @param ptr2 Le pointeur vers le deuxième grand entier à sommer.
 * @pre Le pointeur `result` correspond à une zone mémoire valide.
 * @note La valeur précédemment derrière le pointeur `result` est écrasée.
 */
void largeint_add(largeint *result, largeint *ptr1, largeint *ptr2);

/**
 * @brief Multiplie deux grands entiers et place le résultat derrière le
 * pointeur donné.
 * @param result Le pointeur derrière lequel stocker le produit.
 * @param ptr1 Le pointeur vers le premier grand entier à multiplier.
 * @param ptr2 Le pointeur vers le deuxième grand entier à multiplier.
 * @pre Le pointeur result correspond à une zone mémoire valide.
 * @note La valeur précédente derrière le pointeur `result` est écrasée.
 */
void largeint_multiply(largeint *result, largeint *ptr1, largeint *ptr2);

/** @} */

#endif
