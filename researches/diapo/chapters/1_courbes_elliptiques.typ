#import "@local/typst-packages:0.1.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/theorion:0.6.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": plot

#import cosmos.fancy: *

= Courbes elliptiques

== Définitions

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

#definition[Polynôme homogène"][
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

#columns(2)[
  #let fn = (
    x => + calc.sqrt(x*x*x - 2 * x + 2),
    x => - calc.sqrt(x*x*x - 2 * x + 2),
  )

  #figcan(caption: [Courbe elliptique d'équation \ $y^2 = x^3 - 2 x + 2$.], {
    import draw: *

    // Set-up a thin axis style
    set-style(
      axes: (stroke: .5pt, tick: (stroke: .5pt)),
      legend: (stroke: none, orientation: ltr, item: (spacing: .3), scale: 60%),
    )

    plot.plot(size: (6, 4),
      x-tick-step: 2, x-min: -3, x-max: 4,
      y-tick-step: 4, y-min: -3, y-max: 3,
      legend: "inner-north",
      {
        let domain1 = (-1.76925, 3)

        for (f) in fn {
          plot.add(f, domain: domain1, style: (stroke: black))
        }
      })
  })

  #let fn = (
    x => + calc.sqrt(x*x*x - 5*x + 3),
    x => - calc.sqrt(x*x*x - 5*x + 3),
  )

  #figcan(caption: [Courbe elliptique d'équation \ $y^2 = x^3 - 2x + 3$], {
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
      })
  })

  #let fn = (
    x => + calc.sqrt(x*x*x),
    x => - calc.sqrt(x*x*x),
  )

  #figcan(caption: [Cubique singulière d'équation \ $y^2 = x^3$.], {
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
  })

#let fn = (
    x => + calc.sqrt(x*x*x - 3 * x + 2) - 0.01,
    x => - calc.sqrt(x*x*x - 3 * x + 2) + 0.01,
  )

#figcan(caption: [Cubique singulière d'équation \ $y^2 = x^3 - 3 x + 2$.], {
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
        let domain1 = (-2, 3)

        for (f) in fn {
          plot.add(f, domain: domain1, style: (stroke: black))
        }
      })
  })
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

#corollary[Forme réduite affine][
  #v(5pt)
  En coordonnées non homogènes ($x = X /Z$ et $y = Y / Z$), on peut écrire cette équation :

  $ E : y^2 = x^3 +a x + b $ <eq:WeierAff>

  Ainsi que le point $cal(O) = [0 : 1 : 0]$ qui est le seul point à l'infini.
]

---

#definition[Opposé][Si $P = (x, y) in E$, alors on définit *l'opposé de $P$* par $-P := (x, -y)$.]

#remark[
  Si $P$ et $Q$ sont deux points de $E$ de même abscisse, alors $Q = plus.minus P$.]

---

#proposition[Critère de singularité][
  Soit $E$ une équation sous forme de Weierstrass, alors $E$ est singulière si et seulement si la quantité \ $Delta := 4 a^3 + 27 b^2$ est nulle.
] <sing>

#remark[
  Le vrai discriminant correspond à $16$ fois cette quantité, mais $"Car"(KK) eq.not 2$ donc cela ne change pas la nullité ici.
]

== Structure de groupe abélien

=== Prémices

#proposition[Intersections avec une droite][
  Soient $E$ une courbe elliptique et $L$ une droite. 

  Si $E$ a au moins deux points d'intersection (comptés avec leur multiplicité) avec la droite $L$, alors $E$ a exactement trois points d'intersection (comptés avec leur multiplicité) avec la droite $L$.
]

---

=== Approche géométrique


#definition[Loi de groupe][
  On définit la loi $*$ dite de la *sécante-tangente* par :
  - Si $P$, $Q in E$ avec $P eq.not Q$, alors $P * Q$ est le troisième point d'intersection de la droite passant par $P$ et $Q$ avec $E$. 
  - Si $P in E$, alors $P * P$ est le troisième point d'intersection de la tangente à $E$ en $P.$

  On définit de plus $P + Q := cal(O) * (P * Q) = R$ où $-R$ est le troisième point d'intersection avec la droite.
]

---

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

#align(center)[#figcan(caption: [Calcul de $R = P + Q$ sur $E: y^2 = x^3 - 5x + 3$], {
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

#let fn = (
  x => + calc.sqrt(x*x*x - 5*x + 3),
  x => - calc.sqrt(x*x*x - 5*x + 3),
)

#let points = (
  (0, 1.732, 0.5, 0.6, [$P$]),
  (2.1, -1.3, 0.6, 0.6, [$-R$]),
  (2.1, 1.3, 0.6, 0.6, [$R$]),
)

#let change(x, y) = {
  return (6 * x / 7 + 18 / 7, 2 * y / 5 + 2)
}

#align(center)[#figcan(caption: [Calcul de $R = 2P$ sur $E: y^2 = x^3 - 5x + 3$], {
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
      let domain1 = (-2.49083, +0.6566)
      let domain2 = (+1.8343, +4)

      for (f) in fn {
        plot.add(f, domain: domain1, style: (stroke: black))
        plot.add(f, domain: domain2, style: (stroke: black))
      }

      plot.add(x =>- 5 * 1.732 * x / 6 + 1.75, domain: (-3, 4), style: (stroke: blue))
      plot.add-vline(2.1, style: (stroke: (dash: "dashed")))

    })
    
    for (x, y, dx, dy, name) in points {    
      circle(change(x, y), radius: 0.06, fill: red, stroke: none)
    content(change(x + dx, y + dy), name)
    }
})]

---

=== Approche analytique

#proposition[
  Si $P = (x_1, y_1)$ et $Q = (x_2, y_2)$ sont deux points de $E$ différents de $cal(O)$, alors on définit $P + Q$ comme:

  - Si $P = - Q$, alors $P + Q = P + (-P) = cal(O)$

  - Sinon, on pose $P + Q = (x_3, y_3)$ où $x_3 = lambda^2 - x_1 - x_2$ et $y_3 = lambda(x_1 - x_3) - y_1$ , avec $lambda = cases(
    (3 x_1^2+a) / (2 y_1) "si" P = Q,
    (y_2 - y_1) / (x_2 - x_1) "si" P eq.not Q
  )$.
]

---

#proposition[
  Si $P$ est un point de $E$, alors  $P + cal(O) = cal(O) + P = P$. Cela fait de $cal(O)$ l'élément neutre de $E$.
]

#proposition[
  La loi $+$ est associative et commutative.
]

#theorem[
  $(E, +)$ a une structure de groupe abélien, de neutre $cal(O)$.
]

== Théorème de Hasse

#theorem[Théorème de Hasse][
  Si $p$ est un nombre premier et $E(FF_p)$ une courbe elliptique, alors le cardinal $N$ de $E(FF_p)$ vérifie 

  $ abs(N - (p + 1)) <= 2 sqrt(p) $
] <hasse>

#remark[
  Deuring a prouvé qu'il existait pour chaque valeur de cet intervalle une paire $(a, b)$ où ce cardinal est atteint.
]
