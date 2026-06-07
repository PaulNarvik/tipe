#import "@local/typst-packages:0.1.0": *
#import "@preview/theorion:0.6.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": plot
#import "@preview/codly:1.3.0": *

#show: codly-init.with()
#import cosmos.fancy: *

= Implémentation et résultats

== Implémentation

J'ai choisi pour ce TIPE d'utiliser le langage *C++* avec la librairie *GMP* afin de manipuler des entiers de taille non bornée, et ce afin de ne pas être limité par la taille initiale de 64 bits maximum.

J'ai ensuite opté pour les types suivants lors mon implémentation :

```cpp 
struct ellipticCurve {
  mpz_class a;
  mpz_class b;
  mpz_class p;
}
```

```cpp 
struct ellipticPoint {
  mpz_class x;
  mpz_class y;
  bool infty;
  ellipticCurve *curve;
}
```

J'ai implémenté l'addition de points avec la même disjonction de cas que présentée, et la multiplication rapide de la même manière que l'exponentiation rapide sur les flottants. 

J'ai utilisé le *crible d'Ératosthène* afin d'obtenir les premiers plus petits que $B$, cet algorithme nécessite un espace proportionnel à $B$ ce qui le rend obsolète dès que notre facteur dépasse la cinquantaine de chiffres.

Le test de primalité est réalisé avec l'algorithme de *Miller-Rabin*, et les inversions modulaires par *l'algorithme d'Euclide étendu*.


== Résultats

#figure(caption : "Comparaison des algorithmes naïfs et de Lenstra pour des nombres tirés aléatoirement")[#image("../graphique_temps_moyens_fond_blanc.png")]

#remark[
  L'algorithme naïf ne rendait pas en moins d'une heure pour plus de 30 chiffres. 
]

D'autres tests ont été réalisé avec l'algorithme de Lenstra uniquement, en voici un :

```
n = 70990747356501633610903340638
    49287869508897030027526772787

22:03:08 - Essai pour B = 11000
22:03:08 - Facteur: 219467308483

22:03:08 - Essai pour B = 50000

22:03:11 - Essai pour B = 250000

22:03:28 - Essai pour B = 1000000

22:06:19 - Essai pour B = 3000000
 
22:31:23 - Essai pour B = 11000000
22:32:16 - Facteur: 
            878948692609348221551
22:32:16 - Facteur: 
            36801742833925363771266239

=======================================
Temps d'exécution : 29:07.85 s
Mémoire : 18180 kb
```

#remark[
  Le temps de calcul est plus élevé à cause de la taille des facteurs, pas de celle du produit directement.
]


