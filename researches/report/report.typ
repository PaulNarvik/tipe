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

#include "chapters/1_courbes_elliptiques.typ"
#include "chapters/2_methode_factorisation.typ"
#include "chapters/3_implementation.typ"

#set page(columns: 1)
= Annexes

#include "annexes/1_code.typ"
