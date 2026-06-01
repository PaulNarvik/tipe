#import "@local/typst-packages:0.1.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/theorion:0.6.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": plot

#show: doc => template-slide(
  doc,
  title: "Cryptographie sur les courbes elliptiques",
  subtitle: [Utilisation de la méthode de Lenstra],
  author: [Paul Chaudagne (32452)],
  banner: none
)

#show: codly-init.with()
#codly(languages: codly-languages)

#all_num.update(true)
#box_thickness.update(3pt)

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

#set text(lang: "fr")

#title-slide()

#outline-slide(depth: 1, beginning: true)

#include "chapters/1_courbes_elliptiques.typ"
#include "chapters/2_methode_factorisation.typ"
#include "chapters/3_implementation.typ"

= Conclusion

---

- Calculs bien plus rapides qu'avec l'algorithme naïf, et parallélisation plus facile.

- Ne convient pas aux grands facteurs (par exemple RSA), puisque la borne $B$ explose ainsi que la mémoire nécessaire.

#include "chapters/4_annexes.typ"
