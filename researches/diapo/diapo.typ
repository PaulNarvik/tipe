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

== Conclusion

- Calculs bien plus rapides qu'avec l'algorithme naïf, et parallélisation plus facile.

- Ne convient pas aux grands facteurs (par exemple RSA), puisque la borne $B$ explose ainsi que la mémoire nécessaire.

- Reste un progrès par rapport à l'algorithme naïf et l'un des meilleurs pour des facteurs jusqu'à une cinquantaine de chiffres.

== Bibliographie

1. SAMUEL S. WAGSTAFF, JR. : The Joy of Factoring : #underline[https://www.ams.org/publications/authors/books/postpub/stml-68], ISBN: 978-1-4704-1048-3

2. ALICE BOUILLET, DORIAN BERGER : Arithmétique des courbes elliptiques : #underline[https://perso.eleves.ens-rennes.fr/~aboui725/Stages/TER_M1.pdf]

3.  LAWRENCE C. WASHINGTON : Elliptic Curves Number Theory and Cryptography, Second Edition : CRC Press, Taylor & Francis Group, 2008, ISBN: 978-1-4200-7146-7

4. DIEGO IZQUIERDO : MAT562 : Introduction à la géométrie algébrique et courbes elliptiques : #underline[https://synapses.polytechnique.fr/catalogue/2023-2024/ue/795/MAT562-introduction-a-la-geometrie-algebrique-et-courbes-elliptiques?from=D1]

5. JOSEPH H. SILVERMAN : The Arithmetic of Elliptic Curves : #underline[https://link.springer.com/book/10.1007/978-0-387-09494-6], ISBN: 978-0-387-09493-9

#include "chapters/4_annexes.typ"
