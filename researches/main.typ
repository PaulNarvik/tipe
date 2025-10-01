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
  Soit $KK$ un corps, on appelle plan projectif l'ensemble des classes d'équivalence pour la relation $cal(R)$, noté :

  $ PP^2(KK) = (KK^3 without {(0, 0, 0)}) slash cal(R) $
])

Cela revient à projeter l'espace sur une demi-sphère centrée en (0, 0, 0), où chaque classe d'équivalence correspond à une droite passant par l'origine et un unique point de la demi-sphère, soit en dimension 1 :

#figcan(caption: "Représentation de l'espace projectif en dimension deux.", {
  import draw: *
  arrow((-3, 0), (3, 0))
  arrow((0, -1), (0, 3))
  arc((2, 0), start: 0deg, stop: 180deg, radius: 2, stroke: 1pt + blue)
  arc((2, 0), start: 0deg, delta: 24deg, radius: 2, stroke: 1pt + green)
  arc((2, 0), start: 0deg, delta: 14deg, radius: 2, stroke: 1pt + blue)
  line((-3, -1), (3, 1), stroke: 1pt + red)
})

#defi("Polynôme homogène", [
  Un polynôme homogène est un polynôme en plusieurs indéterminées dont tous les monômes non nuls sont de même degré total.

  Par exemple, un polynôme de degré 3 homogène en trois variables s'écrit sous la forme :

  $ P(X, Y, Z) = a X^3 + b Y^3 + c Z^3 + d X^2 Y + e X^2 Z + f Y^2 X + g Y^2 Z + h Z^2 X + i Z^2 Y + j X Y Z $
])

On remarque en particulier que si $P$ est un polynôme homogène en trois variables de degré $d$, et que $P(x, y, z)=0$, alors :

$ forall (x', y', z') in [(x, y, z)], P(x', y', z') = lambda^d P(x, y, z) = 0 $

#defi("Courbe elliptique", [
  On appelle courbe elliptique sur un corps $KK$, l'ensemble des solutions dans le plan projectif $PP^2(KK)$ de l'équation $F(X, Y, Z) = 0$, où $F$ est un polynôme homogène de degré 3 en trois variables.

  Formellement, pour $F$ polynôme homogène de $KK_3[X, Y, Z]$, on note :

  $ E(KK) = {(x, y, z) in PP^2(KK) , F(x, y, z) = 0} $

  En l'absence d'ambiguïté sur le corps, on notera indistinctement $E(KK$) et $E$ les courbes elliptiques considérées.
])

#defi("Singularité", [
  Un point $P = (x, y, z)$ d'une courbe elliptique est dit singulier lorsque :

  $ ((diff F) / (diff X)(P), (diff F) / (diff Y)(P), (diff F) / (diff Z)(P)) = (0, 0, 0) $

  On dira d'une courbe elliptique qu'elle est lisse (ou  non singulière) si elle ne possède aucun point singulier, soit :

  $ forall P in E(KK), ((diff F) / (diff X)(P), (diff F) / (diff Y)(P), (diff F) / (diff Z)(P)) = (0, 0, 0) $
])

#prop("Mise sous forme normale de Weierstrass", [

])
