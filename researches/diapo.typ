#import "@local/typst-packages:0.1.0": *

#show: doc => template-slide(
  doc,
  title: "Cryptographie sur les courbes elliptiques"
)

#title-slide()
= Les courbes elliptiques

== Définitions

#defi("Espace projectif", [
  Soit $KK$ un corps, on appelle *espace projectif de dimension n* l'ensemble des classes d'équivalence pour la relation $tilde$, noté :

  $ PP^n (KK) = (KK^(n+1) without {(0, ..., 0)}) slash tilde $

  Pour $P = (x_1, ..., x_(n+1)) in KK without{(0, ..., 0)}$, on notera $[x_1 : ... : x_(n+1)]$ la *classe d'équivalence* de $P$ pour la relation $tilde$.

  On appellera en particulier *plan projectif* l'espace projectif de dimension 2.
])

== Formes de Weierstrass

== Structure de groupe abélien
