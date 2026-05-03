#import "@local/typst-packages:0.1.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#show: doc => template-slide(
  doc,
  title: "Cryptographie sur les courbes elliptiques",
  subtitle: [Utilisation de la méthode de Lenstra],
  author: [Paul Chaudagne]
)

#show: codly-init.with()
#codly(languages: codly-languages)

#all_num.update(true)
#box_thickness.update(3pt)

#set text(lang: "fr")

#title-slide()

#outline-slide(depth: 1)

= Les courbes elliptiques

== Définitions

#defi("Plan projectif", [
  - *relation d'équivalence* sur $KK^3$ :
  $ (a_1, a_2, a_3) tilde (a'_1, a'_2, a'_3) equ exists lambda in KK without {0}, (a_1, a_2, a_3) = lambda (a'_1, a'_2, a'_3) $

  - *Plan projectif* :
  $ PP^2 (KK) = (KK^(3) without {(0, 0, 0)}) slash tilde $

  - *Classe d'équivalence* de $(x, y, z)$ :
  $ [x : y : z] $
])

---

#rema("")[
  Cela revient à *projeter l'espace sur une demi-sphère* centrée en $(0, 0)$, où chaque classe d'équivalence correspond à une droite passant par l'origine.
]
#figcan(caption: "Représentation de l'espace projectif de dimension 1.", {
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

#defi("Polynôme homogène", [
  Un *polynôme homogène* est un polynôme en plusieurs indéterminées dont tous les monômes non nuls sont de même degré total.

  Nous ne travaillerons par la suite qu'avec des polynômes de degré 3 homogènes en trois indéterminées, de la forme :

  $ a X^3 + b Y^3 + c Z^3 + d X^2 Y + e X^2 Z + f Y^2 X + g Y^2 Z + h Z^2 X + i Z^2 Y + j X Y Z $
])

#rema("")[
  Si un polynôme homogène s'annule en $(x, y, z) in KK^3$, alors il est nul sur $[x : y : z]$.
]

  #defi("Courbe elliptique", [
    On appelle *courbe elliptique sur un corps $KK$*, l'ensemble des solutions dans le plan projectif $PP^2(KK)$ de l'équation $F(X, Y, Z) = 0$, où $F$ est un polynôme homogène de degré 3 en trois indéterminées à coefficients dans $KK$.

    Formellement, pour $F$ polynôme homogène de $KK_3[X, Y, Z]$, on note :

    $ E = {[x : y : z] in PP^2(KK) , F(x, y, z) = 0} $
  ])

  #rema("")[
    Une courbe elliptique est toujours définie à une constante multiplicative près.
  ]

== Formes de Weierstrass

```ocaml
let rec fact n = if n <= 1 then 1 else n * (fact (n - 1))

let tab = Array.init 10 fact

for int i = 0 to 9 do 
  Printf.printf tab.(i)
done
```

== Structure de groupe abélien

test 

= La méthode de Lenstra 

== Sous partie

Un essai

= Implémentation et résultats

== Ich liebe les pommes

#lorem(80)

== Ich liebe le bleu canard

#lorem(100)

= Autre partie random

== Bob 

Bob voulait écrire à Alice

== Alice 

Alice ne voulait pas lire un message de Bob

== Ève 

Ève est en fait la gentille de l'histoire et intercepta le message

#ending-slide("Thx for watching")

Directed by me
