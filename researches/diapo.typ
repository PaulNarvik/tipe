#import "@local/typst-packages:0.1.0": *

#show: doc => template-slide(
  doc,
  title: "Cryptographie sur les courbes elliptiques",
  subtitle: [Utilisation de la méthode de Lenstra]
)

#all_num.update(true)

#set text(lang: "fr")

#title-slide()

#outline-slide()

= Les courbes elliptiques

== Définitions

#defi("Espace projectif")[
  Soit $KK$ un corps, on appelle *espace projectif de dimension n* l'ensemble des classes d'équivalence pour la relation $tilde$, noté :

  $ PP^n (KK) = (KK^(n+1) without {(0, ..., 0)}) slash tilde $

  Pour $P = (x_1, ..., x_(n+1)) in KK without{(0, ..., 0)}$, on notera $[x_1 : ... : x_(n+1)]$ la *classe d'équivalence* de $P$ pour la relation $tilde$.

  On appellera en particulier *plan projectif* l'espace projectif de dimension 2.
]

== Formes de Weierstrass

J'ai perdu

== Structure de groupe abélien

test 

= La méthode de Lenstra 

== Sous partie

Un essai

= Implémentation et résultats

== Contenu

Toto

== Une autre

#ending-slide("Thx for watching")
