#import "@local/typst-packages:0.1.0": *

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
]

#defi("Espace projectif", [
  Soit $KK$ un corps, on appelle *espace projectif de dimension n* l'ensemble des classes d'équivalence pour la relation $tilde$, noté :

  $ PP^n (KK) = (KK^(n+1) without {(0, ..., 0)}) slash tilde $

  Pour $P = (x_1, ..., x_(n+1)) in KK without{(0, ..., 0)}$, on notera $[x_1 : ... : x_(n+1)]$ la *classe d'équivalence* de $P$ pour la relation $tilde$.

  On appellera en particulier *plan projectif* l'espace projectif de dimension 2.
])

Cela revient à projeter l'espace sur une demi-sphère centrée en (0, 0, 0), où chaque classe d'équivalence correspond à une droite passant par l'origine et un unique point de la demi-sphère, soit en dimension 1 :

#figcan(caption: "Représentation de l'espace projectif de dimension 1.", {
  arrow_fig((-3, 0), (3, 0), style: 0.5pt + black)
  arrow_fig((0, -1), (0, 2.5), style: 0.5pt + black)
  arc((2, 0), start: 0deg, stop: 180deg, radius: 2, stroke: 1pt + blue)
  line((-3, -1), (-0.1, -0.033), stroke: 1pt + red)
  line((0.1, 0.033), (3, 1), stroke: 1pt + red)
  circle((0, 0), radius: 0.1, stroke: 1pt + red)
  circle((1.90, 0.63), radius: 0.05, fill: black)
  content((2.2, 0.4), "P")
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

On notera que multiplier le polynôme par un scalaire non nul ne change pas la courbe elliptique considérée.

#defi("Singularité", [
  Un point $P = [x : y : z]$ d'une courbe elliptique est dit *singulier* lorsque :

  $ ((partial F) / (partial X)(P), (partial F) / (partial Y)(P), (partial F) / (partial Z)(P)) = (0, 0, 0) $

  On dira d'une courbe elliptique qu'elle est *lisse* (ou  *non singulière*) si elle ne possède aucun point singulier, soit :

  $
    forall P in E(KK), ((partial F) / (partial X)(P), (partial F) / (partial Y)(P), (partial F) / (partial Z)(P)) = (0, 0, 0)
  $
])

Par la suite, nous ne considérerons que des courbes elliptiques non singulières définies sur un corps $KK$ de caractéristique différente de 2 ou 3.

#defi("Tangente", [
  Soit $E$ une courbe elliptique, et $P in E$ un point non singulier. Alors la *tangente à $E$ en $P$* est donnée par :

  $
    (partial F) / (partial X) (P) (X - X_P) + (partial F) / (partial Y) (P) (Y - Y_P) + (partial F) / (partial Z) (P) (Z - Z_P) = 0
  $
])

#defi("Point d'inflexion", [
  Soit $E$ une courbe elliptique, on dit qu'un point $P in E$ est un *point d'inflexion* si la tangente à $E$ en $P$ intersecte $E$ en $P$ avec une multiplicité égale à 3.
])

== Forme de Weierstrass

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
  Soit $E$ une courbe elliptique non singulière. Soit $cal(O)$ un point d'inflexion de $E$, si $cal(O) = [0 : 1 : 0]$ et si la tangente à $E$ en $cal(O)$ est $Z = 0$, alors $E$ est de la forme:

  $ Y^2 Z + a_1 Y X Z + a_3 Y Z^2 - (X^3 + a_2 X^2 Z + a_4 X Z^2 + a_6 Z^3) $
]

#preu[
  La forme générale du polynôme qui définit une courbe elliptique est :

  $ F(X, Y, Z) = a X^3 + b Y^3 + c Z^3 + d X^2 Y + e X^2 Z + f Y^2 X + g Y^2 Z + h Z^2 X + i Z^2 Y + j X Y Z $

  Montrons que certains termes s'annulent :

  - F([0 : 1 : 0]) = 0 donc $b = 0$.

  - La tangente à $E$ en $[0 : 1 : 0]$ est $Z = 0$, donc $(partial F) / (partial X) ([0 : 1 : 0]) = f = 0$ et $(partial F) / (partial Z) ([0 : 1 : 0]) = g eq.not 0$
  - L'intersection de la tangente $Z = 0$ en $cal(O)$ avec la courbe est donnée par l'équation $a X^3 + d X^2 Y = 0$, pour avoir ensuite $cal(O)$ point d'inflexion, il faut que ce point soit racine triple de $F(X : 1 : 0) = a X^3 + d X^2$, soit $d = 0$.
  - #result[

      On admet pour l'instant que $a eq.not 0$

      Supposons $a = 0$, on se place alors dans le plan $Z = 0$. Donc : $ (partial F) / (partial X) = 3 a X^2, (partial F) / (partial Z) = e X^2 + j X Y + g Y^2 $

      Montrons alors que ce polynôme peut s'annuler.

      Le problème que je rencontre est que les papiers que je trouve sur le sujet utilise le fait que $KK$ est un corps algébriquement clos, avant de faire les calculs suivants dans $FF_p$.

      Je ne sais pas si cela est gênant ou si le supposer est une véritable perte d'un point de vue théorique.
    ]

  On choisit alors un représentant de $F$ ayant un coefficient $1$ devant $X^3$ (possible car $a eq.not 0$). Ainsi, $F(X, Y, Z) = X^3 + alpha Z^3 + beta X^2 Z + gamma Y^2 Z + delta Z^2 X + epsilon Z^2 Y + zeta X Y Z; gamma eq.not 0$.

  On pose ensuite le changement de variables $Z' = -Z/gamma$, on obtient $F$ sous forme de Weierstrass.
]

#todo[Ne plus admettre :-)]

== Forme de Weierstrass réduite

#theo("Mise sous forme réduite de Weierstrass")[
  Si $"Car"(K) eq.not 2, 3$, on peut mettre une courbe elliptique sous forme de Weierstrass réduite :

  $ Y^2Z = X^3 + a X Z^2 + b Z^3 $ <eq:WeierProj>
]

#preu[
  Soit $E$ une courbe elliptique sous forme de Weierstrass, on pose d'abord pour annuler le terme en $X Y Z$ :

  $ X' = X, Y' = Y + a_1 /2 X, Z' = Z $

  Puis pour éliminer les termes en $X^2$ et $Y$ :

  $ X' = X + a_2 / 3, Y' = Y + a_3 / 2, Z' = Z $

  On arrive alors à la forme souhaitée, on note que ces changements de variables sont possibles grâce à l'hypothèse sur la caractéristique.
]

#todo[Le refaire à la main au moins une fois]


#coro("Forme réduite affine")[
  #v(5pt)
  En coordonnées non homogènes ($x = X /Z$ et $y = Y / Z$), on peut écrire cette équation :

  $ E : y^2 = x^3 +a x + b $ <eq:WeierAff>

  Ainsi que le point $cal(O) = [0 : 1 : 0]$ qui est le seul point à l'infini.
]

#prop("Critère de singularité")[
  Soit $E$ une équation sous forme de Weierstrass, alors $E$ est singulière si et seulement si la quantité $Delta := 4 a^3 + 27 b^2$ est nulle.
]

#preu[
  $E$ est une courbe de $PP^2 (KK)$ donnée par l'équation :

  $ F(X, Y, Z) = Y^2 Z - X^3 - a X Z^2 - b Z^3 $

  D'abord, $(partial F) / (partial Z)(cal(O)) = 1 eq.not 0$.

  Passons maintenant en coordonnées affines :

  $ E : f(x, y) = y^2 - x^3 - a x - b = 0 $

  Si $P = (x_0, y_0)$ est un point singulier, alors $(partial f) / (partial y)(P) = 2y_0 = 0$, donc $y_0 = 0$ comme $"Car"(K) eq.not 2$.

  $(partial f) / (partial x)(P) = 3 x_0^2 - a = 0$, donc $x_0^2 = - a / 3$. D'où $y_0^2 = 0 = x_0^3 +a x_0 + b = 2/3 a x_0 + b$.

  On en déduit $x_0^2 = (9 b^2) / (4 a^2) = -a / 3$. D'où $Delta := 4 a^3 + 27 b^2 = 0$.
]

== Structure de groupe abélien

=== Prémices

#prop("intersections avec une droite")[
  Soient $E$ une courbe elliptique et $L$ une droite définies sur un corps $KK$.

  Si $E$ a au moins deux points d'intersection (comptés avec multiplicité) avec la droite $L$, alors $E$ a exactement trois points d'intersection (comptés avec leur multiplicité) avec la droite $L$
]

#preu[
  On prend $E$ sous forme de Weierstrass, $E : F(X, Y, Z) = Y^2 Z - X^3 -a X Z^2 - b Z^3 = 0$. $L$ est satisfait l'équation $alpha X + beta Y + gamma Z = 0$. Sans perte de généralité, on peut supposer que $alpha eq.not 0$ et que l'équation est alors $X = - beta' Y - gamma' Z$. Le polynôme $P(Y, Z) = F(-beta' Y - gamma' Z, Y, Z)$ est un polynôme admettant
]

#todo[
  Racine réelle ?
  Et si verticale ?
  Preuve mat562 avec 4 racines ou + => nul ?
]

=== Approche géométrique

=== Approche analytique
