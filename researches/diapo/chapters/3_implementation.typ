#import "@local/typst-packages:0.1.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/theorion:0.6.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": plot

#import cosmos.fancy: *

= Implémentation et résultats

== Implémentation

- Langage *C++*, notamment pour la gestion des erreurs.

- Librairie *GMP* afin de manipuler des entiers de taille non bornée.

- J'ai ensuite opté pour les types suivants lors mon implémentation :

#columns(2)[
  ```cpp 
  struct ellipticCurve {
    mpz_class a;
    mpz_class b;
    mpz_class p;
  }
  ```
#colbreak()
  ```cpp 
  struct ellipticPoint {
    mpz_class x;
    mpz_class y;
    bool infty;
    ellipticCurve *curve;
  }
  ```
]

#figure(caption : "Comparaison des algorithmes naïfs et de Lenstra pour des nombres tirés aléatoirement")[#image("../graphique_temps_moyens_fond_blanc.png")]

#remark[
  L'algorithme naïf ne rendait pas en moins d'une heure pour plus de 30 chiffres. 
]

--- 

D'autres tests ont été réalisé avec l'algorithme de Lenstra uniquement, en voici un :

```
n = 7099074735650163361090334063849287869508897030027526772787

22:03:08 - Essai pour B = 11000
22:03:08 - Facteur: 219467308483

22:03:08 - Essai pour B = 50000

22:03:11 - Essai pour B = 250000

22:03:28 - Essai pour B = 1000000

22:06:19 - Essai pour B = 3000000
``` <test1>

---

#codly(offset-from: <test1>)
```
22:31:23 - Essai pour B = 11000000
22:32:16 - Facteur: 878948692609348221551
22:32:16 - Facteur: 36801742833925363771266239

==========================================
Temps d'exécution : 29:07.85 s
Mémoire : 18180 kb
```

#remark[
  Le temps de calcul est plus élevé à cause de la taille des facteurs, pas de celle du produit directement.
]
