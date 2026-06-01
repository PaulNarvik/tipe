#import "@local/typst-packages:0.1.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/theorion:0.6.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": plot

#import cosmos.fancy: *

= Annexes

== Changement de variables 1

#proof[Démonstration de @changement1][
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

== Forme de Weierstrass

#v(120pt)
#proof[Démonstration de @weierstrass][
  La forme générale du polynôme qui définit une courbe elliptique est :

  $ F(X, Y, Z) = a X^3 + b Y^3 + c Z^3 + d X^2 Y + e X^2 Z \ + f Y^2 X + g Y^2 Z + h Z^2 X + i Z^2 Y + j X Y Z $

  Montrons que certains termes s'annulent :

  - F([0 : 1 : 0]) = 0 donc $b = 0$.

  - La tangente à $E$ en $[0 : 1 : 0]$ est $Z = 0$, donc #box($(partial F) / (partial X) ([0 : 1 : 0]) = f = 0$) et $(partial F) / (partial Z) ([0 : 1 : 0]) = g eq.not 0$
  - L'intersection de la tangente $Z = 0$ en $cal(O)$ avec la courbe est donnée par l'équation $a X^3 + d X^2 Y = 0$, pour avoir ensuite $cal(O)$ point d'inflexion, il faut que ce point soit racine triple de $F(X : 1 : 0) = a X^3 + d X^2$, soit $d = 0$.

  #v(100pt)
  - Supposons $a = 0$, on se place alors dans le plan $Z = 0$. Donc : $ (partial F) / (partial X) = 0 quad quad (partial F) / (partial Y) = 0 quad quad (partial F) / (partial Z) = e X^2 + j X Y + g Y^2 $

    Ce polynôme de degré 2 peut donc s'annuler. Quitte à perdre en généralité, on suppose donc $a eq.not 0$ et la courbe reste elliptique.

  On choisit alors un représentant de $F$ ayant un coefficient $1$ devant $X^3$ (possible car $a eq.not 0$). Ainsi, $F(X, Y, Z) = X^3 + alpha Z^3 + beta X^2 Z + gamma Y^2 Z + delta Z^2 X + epsilon Z^2 Y + zeta X Y Z; gamma eq.not 0$.

  On pose ensuite le changement de variables $Z' = -Z/gamma$, on obtient $F$ sous forme de Weierstrass.
]

== Forme de Weierstrass réduite

#proof[Démonstration de @weierstrass_red][
  Soit $E$ une courbe elliptique sous forme de Weierstrass, on pose d'abord, pour annuler le terme en $X Y Z$ :

  $ X' = X, Y' = Y + a_1 /2 X, Z' = Z $

  Puis pour éliminer les termes en $X^2$ et $Y$ :

  $ X' = X + a_2 / 3, Y' = Y + a_3 / 2, Z' = Z $

  On arrive alors à la forme souhaitée, on note que ces changements de variables sont possibles grâce à l'hypothèse sur la caractéristique.
]

== Singularité

#proof[Démonstration de @sing][
  $E$ est une courbe de $PP^2 (KK)$ donnée par l'équation :

  $ F(X, Y, Z) = Y^2 Z - X^3 - a X Z^2 - b Z^3 $

  D'abord, $(partial F) / (partial Z)(cal(O)) = 1 eq.not 0$.

  Passons maintenant en coordonnées affines :

  $ E : f(x, y) = y^2 - x^3 - a x - b = 0 $

  Si $P = (x_0, y_0)$ est un point singulier, alors $(partial f) / (partial y)(P) = 2y_0 = 0$, donc $y_0 = 0$ comme $"Car"(K) eq.not 2$.

  $(partial f) / (partial x)(P) = 3 x_0^2 - a = 0$, donc $x_0^2 = - a / 3$. D'où $y_0^2 = 0 = x_0^3 +a x_0 + b = 2/3 a x_0 + b$.

  On en déduit $x_0^2 = (9 b^2) / (4 a^2) = -a / 3$. D'où $Delta := 4 a^3 + 27 b^2 = 0$.
]

