#import "@local/typst-packages:0.1.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/theorion:0.6.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": plot

#import cosmos.fancy: *

= Courbes elliptiques

== Définitions

#assumption[
  On suppose que $KK$ est un corps de caractéristique distincte de $2$ ou $3$. 
]

#definition[Courbe elliptique][
  On définit une *courbe elliptique* comme l'ensemble des solutions à l'équation : 

  $ E : y^2 = x^3 +a x + b $ <eq:WeierAff>

  Ainsi que le point $cal(O)$, appelé *point à l'infini*.
]

---

#proposition[Critère de singularité][
  Soit $E$ une équation sous forme de Weierstrass, alors $E$ est *singulière* si et seulement si la quantité $Delta := 4 a^3 + 27 b^2$ est nulle.

  Elle est *lisse* ou *non singulière* dans le cas contraire.
] <sing>

#remark[
  Cela signifie que l'on peut définir une tangente à $E$ en tout point.
]

---

#columns(2)[
  #let fn = (
    x => + calc.sqrt(x*x*x - 2 * x + 2),
    x => - calc.sqrt(x*x*x - 2 * x + 2),
  )

  #figcan(caption: [Courbe elliptique lisse d'équation \ $y^2 = x^3 - 2 x + 2$.], {
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

  #figcan(caption: [Courbe elliptique lisse d'équation \ $y^2 = x^3 - 2x + 3$], {
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

  #figcan(caption: [Courbe elliptique singulière d'équation \ $y^2 = x^3$.], {
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

#figcan(caption: [Courbe elliptique singulière d'équation \ $y^2 = x^3 - 3 x + 2$.], {
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

#definition[Opposé][Si $P = (x, y) in E$, alors on définit *l'opposé de $P$* par $-P := (x, -y)$.]

#remark[
  Si $P$ et $Q$ sont deux points de $E$ de même abscisse, alors $Q = plus.minus P$.]

---

== Structure de groupe abélien

=== Prémices

#proposition[Intersections avec une droite][
  Soient $E$ une courbe elliptique et $L$ une droite. 

  Si $E$ a au moins deux points d'intersection (comptés avec leur multiplicité) avec la droite $L$, alors $E$ a exactement trois points d'intersection (comptés avec leur multiplicité) avec la droite $L$.
]

#let change(x, y) = {
  return (9 * x / 7 + 27 / 7, 3 * y / 5 + 3)
}

#let fn = (
  x => + calc.sqrt(x*x*x - 5*x + 3),
  x => - calc.sqrt(x*x*x - 5*x + 3),
)

#let points = (
  (2.5, -2.47, 0.3, 0.6, [$P$]),
  (0.64, 0.25, 0.3, 0.6, [$Q$]),
  (-1, 2.65, 0.2, 0.8, [$R$]),
)

#align(center)[#figcan(caption: [Trois points d'intersection avec $E: y^2 = x^3 - 5x + 3$], {
  import draw: *

  // Set-up a thin axis style
  set-style(
    axes: (stroke: .5pt, tick: (stroke: .5pt)),
    legend: (stroke: none, orientation: ltr, item: (spacing: .3), scale: 60%),
  )

  plot.plot(size: (9, 6),
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
      circle(change(x, y), radius: 0.1, fill: red, stroke: none)
    content(change(x + dx, y + dy), name)
    }
})]

---

=== Approche géométrique


#definition[Loi de la sécante-tangente][
  On définit la loi $*$ dite de la *sécante-tangente* par :

  - Si $P$, $Q in E$ avec $P eq.not Q$, alors $P * Q$ est le troisième point d'intersection de la droite passant par $P$ et $Q$ avec $E$. 
  
  - Si $P in E$, alors $P * P$ est le troisième point d'intersection de la tangente à $E$ en $P.$
]

#definition[Loi de groupe][
  On définit de plus la *loi additive* $P + Q := cal(O) * (P * Q) = R$ où $-R$ est le troisième point d'intersection avec la droite.
]

---

#let change(x, y) = {
  return (18 * x / 7 + 54 / 7, 6 * y / 5 + 6)
}

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

#align(center)[#figcan(caption: [Calcul de $R = P + Q$ sur $E: y^2 = x^3 - 5x + 3$], {
  import draw: *

  // Set-up a thin axis style
  set-style(
    axes: (stroke: .5pt, tick: (stroke: .5pt)),
    legend: (stroke: none, orientation: ltr, item: (spacing: .3), scale: 60%),
  )

  plot.plot(size: (18, 12),
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
      circle(change(x, y), radius: 0.1, fill: red, stroke: none)
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

#align(center)[#figcan(caption: [Calcul de $R = 2P$ sur $E: y^2 = x^3 - 5x + 3$], {
  import draw: *

  // Set-up a thin axis style
  set-style(
    axes: (stroke: .5pt, tick: (stroke: .5pt)),
    legend: (stroke: none, orientation: ltr, item: (spacing: .3), scale: 60%),
  )

  plot.plot(size: (18, 12),
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
      circle(change(x, y), radius: 0.1, fill: red, stroke: none)
    content(change(x + dx, y + dy), name)
    }
})]

---

=== Approche analytique

#proposition[
  Si $P = (x_1, y_1)$ et $Q = (x_2, y_2)$ sont deux points de $E$ différents de $cal(O)$, alors on définit $P + Q$ comme :

  - Si $P = - Q$, alors $P + Q = P + (-P) = cal(O)$.

  - Sinon, on pose $P + Q = (x_3, y_3)$ et alors :

    $ x_3 = lambda^2 - x_1 - x_2 $

    $ y_3 = lambda(x_1 - x_3) - y_1 $

    Avec #text(size: 23pt)[
      $lambda = cases(
      (3 x_1^2+a) / (2 y_1) "si" P = Q,
      (y_2 - y_1) / (x_2 - x_1) "si" P eq.not Q
    )$].
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

