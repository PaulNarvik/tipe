#import "@local/typst-packages:0.1.0": *

#show: doc => template(
  doc,
  title: "Cryprographie sur les courbes elliptiques",
  subtitle: "TIPE",
)

= Les courbes elliptiques

== Définition des courbes elliptiques

#lemm("", [
  La relation $tilde$, définie sur $KK^n without {(0, ..., 0)}$ par :

  $
    forall ((a_1, ..., a_n), (a'_1 ,... , a'_n)) in (KK^n without {(0, ..., 0)})^2,\
    (a_1, ..., a_n) tilde (a'_1, ..., a'_n) equ (exists lambda in KK without {0}, (a_1, ..., a_n) = lambda (a'_1, ..., a'_n))
  $

  est une relation d'équivalence.
])

#preu[
  Par définition d'un corps, on a :
  - $1 in KK$ donc $tilde$ est réflexive
  - Pour tout $lambda in KK without {0}$, $lambda^(-1) in KK$ donc $tilde$ est symétrique
  - Pour tous $lambda, mu in KK without {0}$, $lambda mu in KK$ donc $tilde$ est transitive.

  Conclusion, $tilde$ est une relation d'équivalence.
]

#defi("Espace projectif", [
  Soit $KK$ un corps, on appelle *espace projectif de dimension n* l'ensemble des classes d'équivalence pour la relation $tilde$, noté :

  $ PP^n (KK) = (KK^(n+1) without {(0, ..., 0)}) slash tilde $

  Pour $P = (x_1, ..., x_(n+1)) in KK without{(0, ..., 0)}$, on notera $[x_1 : ... : x_(n+1)]$ la *classe d'équivalence* de $P$ pour la relation $tilde$.

  On appellera en particulier *plan projectif* l'espace projectif de dimension 2.
])

Cela revient à projeter l'espace sur une demi-sphère centrée en (0, 0, 0), où chaque classe d'équivalence correspond à une droite passant par l'origine et un unique point de la demi-sphère, soit en dimension 1 :

#figcan(caption: "Représentation de l'espace projectif de dimension 1.", {
  import draw: *
  arrow((-3, 0), (3, 0))
  arrow((0, -1), (0, 3))
  arc((2, 0), start: 0deg, stop: 180deg, radius: 2, stroke: 1pt + blue)
  line((-3, -1), (3, 1), stroke: 1pt + red)
  circle((1, 1), radius: 0.05, fill: black)
  content((2.5, 0.5), "P")
  content((4, 1.4), "Classe d'équivalence de P")
  content((-4, 1), "Représentants principaux")
})

#defi("Polynôme homogène", [
  Un *polynôme homogène* est un polynôme en plusieurs indéterminées dont tous les monômes non nuls sont de même degré total.

  Par exemple, un polynôme de degré 3 homogène en trois variables s'écrit sous la forme :

  $ P(X, Y, Z) = a X^3 + b Y^3 + c Z^3 + d X^2 Y + e X^2 Z + f Y^2 X + g Y^2 Z + h Z^2 X + i Z^2 Y + j X Y Z $
])

On remarque en particulier que si $P$ est un polynôme homogène en trois variables de degré $d$, et que $P(x, y, z)=0$, alors :

$ forall (x', y', z') in [x : y : z], P(x', y', z') = lambda^d P(x, y, z) = 0 $

Dans le plan projectif, l'annulation d'un polynôme homogène ne dépend donc pas du représentant choisi.

#defi("Courbe elliptique", [
  On appelle *courbe elliptique sur un corps $KK$*, l'ensemble des solutions dans le plan projectif $PP^2(KK)$ de l'équation $F(X, Y, Z) = 0$, où $F$ est un polynôme homogène de degré 3 en trois variables à coefficients dans $KK$.

  Formellement, pour $F$ polynôme homogène de $KK_3[X, Y, Z]$, on note :

  $ E(KK) = {[x : y : z] in PP^2(KK) , F(x, y, z) = 0} $

  En l'absence d'ambiguïté sur le corps, on notera indistinctement $E(KK$) et $E$ les courbes elliptiques considérées.
])

#defi("Singularité", [
  Un point $P = [x : y : z]$ d'une courbe elliptique est dit *singulier* lorsque :

  $ ((diff F) / (diff X)(P), (diff F) / (diff Y)(P), (diff F) / (diff Z)(P)) = (0, 0, 0) $

  On dira d'une courbe elliptique qu'elle est *lisse* (ou  *non singulière*) si elle ne possède aucun point singulier, soit :

  $ forall P in E(KK), ((diff F) / (diff X)(P), (diff F) / (diff Y)(P), (diff F) / (diff Z)(P)) = (0, 0, 0) $
])

Par la suite, nous ne considérerons que des courbes elliptiques non singulières définies sur un corps $KK$ de caractéristique différente de 2 ou 3.

#defi("Tangente", [
  Soit $E$ une courbe elliptique, et $P in E$ un point non singulier. Alors la *tangente à $E$ en $P$* est donnée par :

  $ (diff F) / (diff X) (P) (X - X_P) + (diff F) / (diff Y) (P) (Y - Y_P) + (diff F) / (diff Z) (P) (Z - Z_P) = 0 $
])

#defi("Point d'inflexion", [
  Soit $E$ une courbe elliptique, on dit qu'un point $P in E$ est un *point d'inflexion* si la tangente à $E$ en $P$ intersecte $E$ en $P$ avec une multiplicité égale à 3.
])

#prop("")[
  Soit $E$ une courbe elliptique non singulière sur $KK$. Soit $P$ un point d'inflexion de $E$.

  Alors un changement de variables linéaire inversible permet de transformer $P$ en $[0 : 1: 0]$ et la tangente en $P$ en $Z = 0$.
]

#preu()[
  Soit $L$ la tangente à $E$ en $P = [x_P : y_P : z_P]$.
  Soit $Q = [x_Q : y_Q : z_Q] in L without E$, les vecteurs $(x_P, y_P, z_P)$ et $x_Q, y_Q, z_Q)$ sont linéairement indépendants car $P$ et $Q$ correspondent à deux points distincts du plan projectif.

  On complète avec un vecteur $C$ en une base de $KK^3$. On obtient alors :
  $
    M = mat(
      x_Q, x_P, ;
      y_Q, y_P, C;
      z_Q, z_P, ;
    )
  $

  $M$ est inversible. $M^(-1)$ envoie $P$ sur le point $[0 : 1 : 0]$ et $Q$ sur le point $[1 : 0 : 0]$. Donc $M^(-1)$ envoie $L$ sur $Z = 0$ car c'est l'unique droite passant par $P$ et $Q$.
]

#theo("Mise sous forme de Weierstrass")[
  Soit $E$ une courbe elliptique non singulière. Soit $cal(O)$ un point d'inflexion de $E$, si $cal(O) = [0 : 1 : 0]$ et la tangente à $E$ en $cal(O)$ est $Z = 0$, alors $E$ est de la forme:

  $ Y^2 Z + a_1 Y X Z + a_3 Y Z^2 - (X^3 + a_2 X^2 Z + a_4 X Z^2 + a_6 Z^4) $ <eq:FormeNormWeier>
]

#preu[
  La forme générale du polynôme qui définit une courbe elliptique est :

  $ P(X, Y, Z) = a X^3 + b Y^3 + c Z^3 + d X^2 Y + e X^2 Z + f Y^2 X + g Y^2 Z + h Z^2 X + i Z^2 Y + j X Y Z $

  Montrons que certains termes s'annulent.
]
