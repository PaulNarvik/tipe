#import "@local/typst-packages:0.1.0": *
#import "@preview/theorion:0.6.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": plot

#import cosmos.fancy: *

= Les courbes elliptiques

== Définition des courbes elliptiques

#definition[Plan projectif][
  Soit $KK$ un corps. On définit la relation d'équivalence $tilde$ sur $KK^3 without {(0, 0, 0)}$ par $(a_1, a_2, a_3) tilde (a'_1, a'_2, a'_3)$ si et seulement s'il  existe $lambda in KK without {0}$ tel que : 

  $ (a_1, a_2, a_3) = lambda (a'_1, a'_2, a'_3) $

  On appelle *plan projectif* l'ensemble des classes d'équivalence pour $tilde$, noté :

  $ PP^2 (KK) := (KK^(3) without {(0, 0, 0)}) slash tilde $

  Pour $P = (x, y, z in KK without{(0, 0, 0)}$, on notera #box($[x : y : z]$) la *classe d'équivalence de $P$* pour $tilde$.
]

Cela revient à projeter l'espace sur une demi-sphère centrée en (0, 0), où chaque classe d'équivalence correspond à une droite passant par l'origine et un unique point de la demi-sphère, soit en dimension 1 :

#figcan(caption: "Espace projectif de dimension 1.", {
  import draw: *
  arrow_fig((-3, 0), (3, 0), style: 0.5pt + black)
  arrow_fig((0, -1), (0, 2.5), style: 0.5pt + black)
  arc((2, 0), start: 0deg, stop: 180deg, radius: 2, stroke: 1pt + blue)
  line((-3, -1), (-0.1, -0.033), stroke: 1pt + red)
  line((0.1, 0.033), (3, 1), stroke: 1pt + red)
  circle((0, 0), radius: 0.1, stroke: 1pt + red)
  circle((1.90, 0.63), radius: 0.05, fill: black)
  content((2.2, 0.4), "P")
  content((2.1, 1.4), "Classe d'équivalence de P")
  content((-3, 1.9), "Représentants principaux")
})

#definition[Polynôme homogène][
  Un *polynôme homogène* est un polynôme en plusieurs indéterminées dont tous les monômes non nuls sont de même degré total.

  Nous ne travaillerons, par la suite qu'avec des polynômes de degré 3 homogènes en trois indéterminées, de la forme :

  $ a X^3 + b Y^3 + c Z^3 + d X^2 Y + e X^2 Z +f Y^2 X \ + g Y^2 Z + h Z^2 X + i Z^2 Y + j X Y Z $
]

On remarque en particulier que si $P$ est un polynôme homogène et que $P(x, y, z)=0$, alors :

$ forall (x', y', z') in [x : y : z], P(x', y', z') = lambda^3 P(x, y, z) = 0 $

Dans le plan projectif, l'annulation d'un polynôme homogène ne dépend donc pas du représentant choisi.

#definition[Courbe elliptique][
  On appelle *courbe elliptique sur un corps $KK$*, l'ensemble des solutions dans le plan projectif $PP^2(KK)$ de l'équation $F(X, Y, Z) = 0$, où $F$ est un polynôme homogène de degré 3 en trois indéterminées à coefficients dans $KK$.

  Formellement, pour $F$ polynôme homogène de $KK_3[X, Y, Z]$, on note :

  $ E(KK) := {[x : y : z] in PP^2(KK) , F(x, y, z) = 0} $

  En l'absence d'ambiguïté sur le corps, on notera indistinctement $E(KK$) et $E$ les courbes elliptiques considérées.
]

On notera que multiplier le polynôme par un scalaire non nul ne change pas la courbe elliptique considérée.

#definition[Singularité][
  Un point $P = [x : y : z]$ d'une courbe elliptique est dit *singulier* lorsque :

  $ ((partial F) / (partial X)(P), (partial F) / (partial Y)(P), (partial F) / (partial Z)(P)) = (0, 0, 0) $

  On dira d'une courbe elliptique qu'elle est *lisse* (ou  *non singulière*) si elle ne possède aucun point singulier, soit :

  $
    forall P in E(KK), ((partial F) / (partial X)(P), (partial F) / (partial Y)(P), (partial F) / (partial Z)(P)) eq.not (0, 0, 0)
  $
]

#let fn = (
  x => + calc.sqrt(x*x*x),
  x => - calc.sqrt(x*x*x),
)

#align(center)[#figcan(caption: [Courbe elliptique singulière définie par $y^2 = x^3$.], {
  import draw: *

  // Set-up a thin axis style
  set-style(
    axes: (stroke: .5pt, tick: (stroke: .5pt)),
    legend: (stroke: none, orientation: ltr, item: (spacing: .3), scale: 60%),
  )

  plot.plot(size: (6, 4),
    x-tick-step: 2, x-min: -1, x-max: 4,
    y-tick-step: 4, y-min: -5, y-max: 5,
    legend: "inner-north",
    {
      let domain1 = (0, 3)

      for (f) in fn {
        plot.add(f, domain: domain1, style: (stroke: black))
      }
    })
})]

Par la suite, nous ne considérerons que des courbes elliptiques non singulières définies sur un corps $KK$ de caractéristique différente de 2 ou 3.

#definition[Tangente][
  Soit $E$ une courbe elliptique, et $P in E$ un point non singulier. Alors la *tangente à $E$ en $P$* est donnée par :

  $
    (partial F) / (partial X) (P) (X - X_P) + (partial F) / (partial Y) (P) (Y - Y_P) +  \ (partial F) / (partial Z) (P) (Z - Z_P) = 0
  $
]

#definition[Point d'inflexion][
  Soit $E$ une courbe elliptique, on dit qu'un point $P in E$ est un *point d'inflexion* si la tangente à $E$ en $P$ coupe $E$ en $P$ avec une multiplicité égale à 3.
]

== Forme de Weierstrass

#proposition[][
  Soient $E$ une courbe elliptique non singulière sur $KK$ et $P$ un point d'inflexion de $E$.

  Alors un changement de variables linéaire inversible permet de transformer $P$ en $[0 : 1: 0]$ et la tangente en $P$ en $Z = 0$.
]

#proof[
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

On peut donc se contenter d'étudier ce cas particulier dans la suite, et en déduire une étude générale.

#theorem[Mise sous forme de Weierstrass][
  Soit $E$ une courbe elliptique non singulière. Soit $cal(O)$ un point d'inflexion de $E$, si $cal(O) = [0 : 1 : 0]$ et si la tangente à $E$ en $cal(O)$ est $Z = 0$, alors $E$ est de la forme:

  $ Y^2 Z + a_1 Y X Z + a_3 Y Z^2\  - (X^3 + a_2 X^2 Z + a_4 X Z^2 + a_6 Z^3) = 0 $
]

#proof[
  La forme générale du polynôme qui définit une courbe elliptique est :

  $ F(X, Y, Z) = a X^3 + b Y^3 + c Z^3 + d X^2 Y + e X^2 Z \ + f Y^2 X + g Y^2 Z + h Z^2 X + i Z^2 Y + j X Y Z $

  Montrons que certains termes s'annulent :

  - F([0 : 1 : 0]) = 0 donc $b = 0$.

  - La tangente à $E$ en $[0 : 1 : 0]$ est $Z = 0$, donc #box($(partial F) / (partial X) ([0 : 1 : 0]) = f = 0$) et $(partial F) / (partial Z) ([0 : 1 : 0]) = g eq.not 0$
  - L'intersection de la tangente $Z = 0$ en $cal(O)$ avec la courbe est donnée par l'équation $a X^3 + d X^2 Y = 0$, pour avoir ensuite $cal(O)$ point d'inflexion, il faut que ce point soit racine triple de $F(X : 1 : 0) = a X^3 + d X^2$, soit $d = 0$.
  - Supposons $a = 0$, on se place alors dans le plan $Z = 0$. Donc : $ (partial F) / (partial X) = 0 quad quad (partial F) / (partial Y) = 0 quad quad (partial F) / (partial Z) = e X^2 + j X Y + g Y^2 $

    Ce polynôme de degré 2 peut donc s'annuler. Quitte à perdre en généralité, on suppose donc $a eq.not 0$ et la courbe reste elliptique.

  On choisit alors un représentant de $F$ ayant un coefficient $1$ devant $X^3$ (possible car $a eq.not 0$). Ainsi, $F(X, Y, Z) = X^3 + alpha Z^3 + beta X^2 Z + gamma Y^2 Z + delta Z^2 X + epsilon Z^2 Y + zeta X Y Z; gamma eq.not 0$.

  On pose ensuite le changement de variables $Z' = -Z/gamma$, on obtient $F$ sous forme de Weierstrass.
]

== Forme de Weierstrass réduite

#theorem[Mise sous forme réduite de Weierstrass][
  Si $"Car"(K) eq.not 2, 3$, on peut mettre une courbe elliptique sous forme de Weierstrass réduite :

  $ Y^2Z = X^3 + a X Z^2 + b Z^3 $ <eq:WeierProj>
]

#proof[
  Soit $E$ une courbe elliptique sous forme de Weierstrass, on pose d'abord, pour annuler le terme en $X Y Z$ :

  $ X' = X, Y' = Y + a_1 /2 X, Z' = Z $

  Puis pour éliminer les termes en $X^2$ et $Y$ :

  $ X' = X + a_2 / 3, Y' = Y + a_3 / 2, Z' = Z $

  On arrive alors à la forme souhaitée, on note que ces changements de variables sont possibles grâce à l'hypothèse sur la caractéristique.
]

#corollary[Forme réduite affine][
  #v(5pt)
  En coordonnées non homogènes ($x = X /Z$ et $y = Y / Z$), on peut écrire cette équation :

  $ E : y^2 = x^3 +a x + b $ <eq:WeierAff>

  Ainsi que le point $cal(O) = [0 : 1 : 0]$ qui est le seul point à l'infini.
]

On remarque que si $P$ et $Q$ sont deux points de $E$ ont même abscisse, alors $Q = plus.minus P$.

#proposition[Critère de singularité][
  Soit $E$ une équation sous forme de Weierstrass, alors $E$ est singulière si et seulement si la quantité $Delta := 4 a^3 + 27 b^2$ est nulle.
]

#proof[
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

#proposition[Intersections avec une droite][
  Soient $E$ une courbe elliptique et $L$ une droite définies sur un corps $KK$. 

  Si $E$ a au moins deux points d'intersection (comptés avec multiplicité) avec la droite $L$, alors $E$ a exactement trois points d'intersection (comptés avec leur multiplicité) avec la droite $L$.
]

=== Approche géométrique

#definition[Opposé][Si $P = (x, y) in E$, alors on définit *l'opposé de $P$* par $-P := (x, -y)$.]

#definition[Loi de la sécante-tangente][
  On définit la loi $*$ dite de la *sécante-tangente* par :
  - Si $P$, $Q in E$ avec $P eq.not Q$, alors $P * Q$ est le troisième point d'intersection de la droite passant par $P$ et $Q$ avec $E$. 
  - Si $P in E$, alors $P * P$ est le troisième point d'intersection de la tangente à $E$ en $P.$
]

#definition[Loi de groupe][
  On définit de plus la *loi additive* $P + Q := cal(O) * (P * Q) = R$ où $-R$ est le troisième point d'intersection avec la droite.
]

#let fn = (
  x => + calc.sqrt(x*x*x - 5*x + 3),
  x => - calc.sqrt(x*x*x - 5*x + 3),
)

#let points = (
  (2.5, -2.47, 0.3, 0.6, [$P$]),
  (0.64, 0.25, 0.3, 0.6, [$Q$]),
  (-1, 2.65, 0.4, 0.5, [$-R$]),
  (-1, -2.65, 0.2, 0.8, [$R$]),
)

#let change(x, y) = {
  return (6 * x / 7 + 18 / 7, 2 * y / 5 + 2)
}

#align(center)[#figcan(caption: [Calcul de $R = P + Q$ sur $E: y^2 = x^3 - 2x + 3$], {
  import draw: *

  // Set-up a thin axis style
  set-style(
    axes: (stroke: .5pt, tick: (stroke: .5pt)),
    legend: (stroke: none, orientation: ltr, item: (spacing: .3), scale: 60%),
  )

  plot.plot(size: (6, 4),
    x-tick-step: 2, x-min: -3, x-max: 4,
    y-tick-step: 4, y-min: -5, y-max: 5,
    legend: "inner-north",
    {
      let domain1 = (-2.4908, +0.6566)
      let domain2 = (+1.8343, +4)

      for (f) in fn {
        plot.add(f, domain: domain1, style: (stroke: black))
        plot.add(f, domain: domain2, style: (stroke: black))
      }

      plot.add(x => (-2.47 - 0.25) / ( 2.5 - 0.64) * (x - 2.5) - 2.47, domain: (-3, 4), style: (stroke: blue))
      plot.add-vline(-1, style: (stroke: (dash: "dashed")))

    })
    
    for (x, y, dx, dy, name) in points {    
      circle(change(x, y), radius: 0.06, fill: red, stroke: none)
    content(change(x + dx, y + dy), name)
    }
})]

=== Approche analytique

#proposition[
  Si $P$ est un point de $E$, alors  $P + cal(O) = cal(O) + P = P$. Cela fait de $cal(O)$ l'élément neutre de $E$.
]

#proposition[
  Si $P = (x_1, y_1)$ et $Q = (x_2, y_2)$ sont deux points de $E$ différents de $cal(O)$, alors on définit $P + Q$ comme:

  - Si $P = - Q$, alors $P + Q = P + (-P) = cal(O)$

  - Sinon, on pose $P + Q = (x_3, y_3)$ où $x_3 = lambda^2 - x_1 - x_2$ et $y_3 = lambda(x_1 - x_3) - y_1$ , avec $lambda = cases(
    (3 x_1^2+a) / (2 y_1) "si" P = Q,
    (y_2 - y_1) / (x_2 - x_1) "si" P eq.not Q
  )$.
]

#proof[
  Si $P eq.not Q$ et $P eq.not -Q$, la sécante passant par $P$ et $Q$ a pour pente $lambda = (y_2 - y_1) / (x/2 - x_1)$, et est donc d'équation $y = lambda x + delta$ où $delta = y_1 - lambda x_1$ est l'ordonné à l'origine.

  $ f(x, lambda x + delta) = -x ^3 + lambda^2 x^2 + (2 lambda delta - a) x + (delta^2 - b)$

  Donc par la formule de Viète, $lambda^2 = x_1 + x_2 + x_3$, et $x_3 = lambda^2 - x_1 - x_2$.

  Dans le cas $P = Q$, on a la même preuve en prenant $lambda = (3 x_1^2 + a) / (2 y_1)$ la pente de la tangente à $E$ en $P$.
]

C'est justement la nécessité d'un inverse qui permettra plus tard de trouver un facteur premier.

#proposition[
  La loi $+$ est associative et commutative.
]

#proof[
  On montrer la commutativité géométriquement, et l'injectivité par le calcul en injectant les différentes expressions des coordonnées.
]

#theorem[
  $(E, +)$ a une structure de groupe abélien, avec $cal(O)$ le neutre du groupe.
]

// == Théorème de Hasse
//
// #theorem[Théorème de Hasse][
//   Si $p$ est un nombre premier et $E(FF_p)$ une courbe elliptique, alors le cardinal N de $E(FF_p)$ vérifie 
//
//   $ abs(N - (p + 1)) <= 2 sqrt(p) $
// ] <hasse>
//
// On notera que Deuring a prouvé qu'il existait pour chaque valeur de cet intervalle une paire $(a, b)$ où ce cardinal.
