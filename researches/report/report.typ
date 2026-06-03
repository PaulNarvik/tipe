#import "@local/typst-packages:0.1.0": *
#import "@preview/theorion:0.6.0": *

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *
#show: codly-init.with()

#codly(
  languages: codly-languages
)

#show: doc => template(
  doc,
  author: "Paul Chaudagne (n° 32452)",
  title: "TIPE - Courbes elliptiques et factorisation",
  subtitle: "Utilisation de la méthode de Lenstra",
  footer: ("", ""),
  empty_footer: true
)

#all_num.update(true)
#box_thickness.update(2pt)

#set page(columns: 2)
#set list(marker: (level) => {
    align(top, sym.bullet) // In some cases works best with horizon
})

#place(
  top + center,
  scope: "parent",
  float: true
)[
  #text(size: 20pt, weight: "extrabold")[TIPE - Courbes elliptiques et factorisation]

  #text(size: 16pt, weight: "bold")[
     Paul Chaudagne (n° 32452)
  ]
  
  #v(10pt)
]

#place(
  top,
  scope: "parent",
  float: true
)[
    Nous allons dans ce TIPE définir des ensembles que l'on munira d'une structure de groupes, appelés courbes elliptiques. Nous utiliserons ensuite ces courbes elliptiques afin de décomposer en produit de facteurs premiers des nombres composés.
]

#import cosmos.fancy: *
#show: show-theorion
#set-inherited-levels(0)

#set-primary-border-color(green.darken(30%))
#set-primary-body-color(green.lighten(80%))
#set-primary-title-color(green.lighten(50%))

#set-secondary-border-color(red.darken(30%))
#set-secondary-body-color(red.lighten(80%))
#set-secondary-title-color(red.lighten(50%))

#set-tertiary-border-color(blue.darken(30%))
#set-tertiary-body-color(blue.lighten(80%))
#set-tertiary-title-color(blue.lighten(50%))

#set-quaternary-border-color(purple.darken(30%))
#set-quaternary-body-color(purple.lighten(80%))
#set-quaternary-title-color(purple.lighten(50%))

#set-fancy-radius(2pt)
#set-title-radius(4pt)
#set-breakable(true)
#set-title-font-color(black)

#outline(depth: 2)

#include "chapters/1_courbes_elliptiques.typ"
#include "chapters/2_methode_factorisation.typ"
#include "chapters/3_implementation.typ"

#colbreak()

= Conclusion

L'algorithme de Lenstra est utilisable en pratique pour factoriser des entiers ayant des facteurs ne dépassant pas une cinquantaine de chiffres mais devient inutilisable ensuite avec l'explosion de la borne de lissité et donc de l'espace mémoire disponible pour calculer les nombres premiers nécessaires.

Il s'agit de plus d'un algorithme facilement parallélisable en lançant de manière concurrente différents threads sur des courbes elliptiques différentes.

#set page(columns: 1)

= Bibliographie

1. SAMUEL S. WAGSTAFF, JR. : The Joy of Factoring : #underline[https://www.ams.org/publications/authors/books/postpub/stml-68], ISBN: 978-1-4704-1048-3

2. ALICE BOUILLET, DORIAN BERGER : Arithmétique des courbes elliptiques : #underline[https://perso.eleves.ens-rennes.fr/~aboui725/Stages/TER_M1.pdf]

3.  LAWRENCE C. WASHINGTON : Elliptic Curves Number Theory and Cryptography, Second Edition : CRC Press, Taylor & Francis Group, 2008, ISBN: 978-1-4200-7146-7

4. DIEGO IZQUIERDO : MAT562 : Introduction à la géométrie algébrique et courbes elliptiques : #underline[https://synapses.polytechnique.fr/catalogue/2023-2024/ue/795/MAT562-introduction-a-la-geometrie-algebrique-et-courbes-elliptiques?from=D1]

5. JOSEPH H. SILVERMAN : The Arithmetic of Elliptic Curves : #underline[https://link.springer.com/book/10.1007/978-0-387-09494-6], ISBN: 978-0-387-09493-9

= Annexes

#include "annexes/1_code.typ"
