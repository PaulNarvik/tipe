#import "@preview/touying:0.6.2": *
#import "my-theme.typ": *

#show: my-theme.with(
  aspect-ratio: "4-3",
  footer: self => self.info.institution,
  config-info(
    title: [Courbes elliptiques et factorisation],
    subtitle: [Utilisation des courbes elliptiques sous forme de Weierstrass pour la factorisation d'entiers avec l'algorithme de Lenstra],
    author: [Paul Chaudagne],
    date: datetime.today(),
    institution: [Institution],
  ),
)

#title-slide()

= First Section

== First Slide

UwU

= Second section

Other 

= Third section

Toto

= Fourth Section

== First Slide

UwU

= Fifth section

Other 

= Sixth section

== A try

Toto

== Test

A slide with a title and an *important* information.
