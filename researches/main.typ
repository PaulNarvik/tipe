#import "@local/typst-packages:0.1.0": *

#show: doc => template(
  doc,
  title: "Cryprographie sur les courbes elliptiques",
  subtitle: "TIPE",
)

= Les courbes elliptiques

== Définition des courbes elliptiques

#lemm("", [
  La relation $cal(R)$, définie sur $KK^3 without {(0, 0, 0)}$ par :

  $
    forall ((a, b, c), (a' ,b', c')) in (KK^3 without {(0, 0, 0)})^2,\
    (a, b, c) cal(R) (a', b', c') equ (exists lambda in KK without {0}, (a, b, c) = lambda (a', b', c'))
  $

  est une relation d'équivalence.
])

#preu[
  Par définition d'un corps, on a :
  - $cal(R)$ est réflexive car $1 in KK$
  - $cal(R)$ est symétrique car pour tout $lambda$ dans $KK without {0}$, $lambda^(-1) in KK$
  - $cal(R)$ est transitive car pour tous $lambda, mu in KK, lambda mu in KK$

  Donc $cal(R)$ est une relation d'équivalence.
]

#defi("Plan projectif", [
  Soit $KK$ un corps, on appelle plan projectif l'ensemble des classes d'équivalence :

  $ PP^2(KK) = (KK^3 without {(0, 0, 0)}) slash cal(R) $
])

Cela revient à projeter l'espace sur une demi-sphère centrée en (0, 0, 0), où chaque classe d'équivalence correspond à une droite passant par l'origine et un unique point de la demi-sphère, soit en dimension deux :

#todo[Schéma ]

#defi("Courbe elliptique", "")

#prop("", "")
