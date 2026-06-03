#definition[Plan projectif][
  - $KK$ est un *corps* de caractéristique différente de $2$ ou $3$.

  - *Relation d'équivalence* sur $KK^3$ :
  $ (a_1, a_2, a_3) tilde (a'_1, a'_2, a'_3) equ exists lambda in KK without {0}, (a_1, a_2, a_3) = lambda (a'_1, a'_2, a'_3) $

  - *Plan projectif* :
  $ PP^2 (KK) = (KK^(3) without {(0, 0, 0)}) slash tilde $

  - *Classe d'équivalence* de $(x, y, z)$ :
  $ [x : y : z] $
]

---

#remark[
  On *projette l'espace sur une demi-sphère* centrée en $(0, 0)$, chaque classe d'équivalence correspond à une droite passant par l'origine.
]
#figcan(caption: "Représentation de l'espace projectif de dimension 1.", {
  import draw: *
  arrow_fig((-6, 0), (6, 0), style: 1pt + black)
  arrow_fig((0, -1), (0, 7), style: 1pt + black)
  arc((5, 0), start: 0deg, stop: 180deg, radius: 5, stroke: 2pt + blue)
  line((-3, -1), (-0.2, -0.066), stroke: 2pt + red)
  line((0.2, 0.066), (6, 2), stroke: 2pt + red)
  circle((0, 0), radius: 0.2, stroke: 2pt + red)
  circle((4.75, 1.575), radius: 0.05, fill: black)
  content((5.5, 1), "P")
  content((9, 2.6), "Classe d'équivalence de P")
  content((-8, 4), "Représentants principaux")
  circle((-12, 5), stroke: white) // Magouille de centrage
})

---

#definition[Polynôme homogène][
  Un *polynôme homogène* est un polynôme en plusieurs indéterminées dont tous les monômes non nuls sont de même degré total.
]

#remark[
  On prendra par la suite des polynômes homogènes de degré 3 en trois indéterminées : 

  $ a X^3 + b Y^3 + c Z^3 + d X^2 Y + e X^2 Z + f Y^2 X + g Y^2 Z + h Z^2 X + i Z^2 Y + j X Y Z $
]

#remark[
  Si un polynôme homogène s'annule en $(x, y, z) in KK^3$, alors il est nul sur $[x : y : z]$.
]

---

#definition[Cubique][
  Une *cubique sur un corps $KK$*, l'ensemble des solutions dans $PP^2(KK)$ de l'équation $F(X, Y, Z) = 0$, où $F in KK[X, Y, Z]$ est un polynôme homogène de degré 3. On note :

  $ V = {[x : y : z] in PP^2(KK) , F(x, y, z) = 0} $
]

#remark[
  Une cubique est toujours définie à une constante multiplicative près.
]

---

#definition[Singularité][
  - Un point $P = [x : y : z]$ est *singulier* lorsque :

  $ ((partial F) / (partial X)(P), (partial F) / (partial Y)(P), (partial F) / (partial Z)(P)) = (0, 0, 0) $

  - Une cubique est *lisse* ou  *non singulière* si elle ne possède aucun point singulier:

  $
    forall P in V, ((partial F) / (partial X)(P), (partial F) / (partial Y)(P), (partial F) / (partial Z)(P)) eq.not (0, 0, 0)
  $
]

#definition[Courbe elliptique][
  Une *courbe elliptique* est une cubique lisse. On la note $E(KK)$, ou $E$ en l'absence d'ambiguïté.
]

---

#definition[Tangente][
  Si $E$ est une courbe elliptique et $P$ un point, la *tangente à $E$  en $P$* est donnée par :

  $
    (partial F) / (partial X) (P) (X - X_P) + (partial F) / (partial Y) (P) (Y - Y_P) + (partial F) / (partial Z) (P) (Z - Z_P) = 0
  $
]

#remark[
  C'est une droite bien définie car $E$ n'est pas singulière.
]

---

#definition[Point d'inflexion][
  Si $E$ est une courbe elliptique, on dit qu'un point $P in E$ est un *point d'inflexion* si la tangente à $E$ en $P$ coupe $E$ en $P$ avec une multiplicité égale à 3.
]

#remark[En d'autres termes, $P$ est une racine triple de $F$.]

== Forme de Weierstrass

#proposition[][
  Si $E$ est une courbe elliptique et $P$ un point d'inflexion de $E$.

  Alors un changement de variables linéaire inversible permet de transformer $P$ en $[0 : 1: 0]$ et la tangente en $P$ en $Z = 0$.
] <changement1>

#remark[
  On se limitera à ce cas d'étude par la suite.
]

---

#theorem[Mise sous forme de Weierstrass][
  Si $E$ est une courbe elliptique et $cal(O)$ un point d'inflexion de $E$ tel que la tangente à $E$ en $cal(O)$ soit $Z = 0$.

  Alors $E$ peut se mettre sous la forme:

  $ Y^2 Z + a_1 Y X Z + a_3 Y Z^2 - (X^3 + a_2 X^2 Z + a_4 X Z^2 + a_6 Z^3) = 0 $
] <weierstrass>

== Forme de Weierstrass réduite

#theorem[Mise sous forme réduite de Weierstrass][
  Si $"Car"(KK) eq.not 2, 3$, on peut mettre une courbe elliptique sous forme de Weierstrass réduite :

  $ Y^2Z = X^3 + a X Z^2 + b Z^3 $ <eq:WeierProj>
] <weierstrass_red>

#remark[
  Le vrai discriminant correspond à $16$ fois cette quantité, mais $"Car"(KK) eq.not 2$ donc cela ne change pas la nullité ici.
]

#remark[
  Deuring a prouvé qu'il existait pour chaque valeur de cet intervalle une paire $(a, b)$ où ce cardinal est atteint.
]
