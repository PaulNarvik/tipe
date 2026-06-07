#import "@local/typst-packages:0.1.0": *
#import "@preview/theorion:0.6.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": plot

#import cosmos.fancy: *

== Fonction de Dickman

La fonction de Dickman est une fonction permettant d'estimer le nombre d'entiers friables jusqu'à une certaine borne.

Elle est définie pour $u > 0$ par :

$ rho(u) = "lim"_(x->+infinity) 1/x abs({1 <= n <= x; P_1(n) <= x^(1 / u)}) $

Où $P_1(n)$ est le plus grand diviseur premier de $n$.

On peut en trouver une approximation lorsque $u$ tend vers l'infini par le calcul : 

$ rho(u) approx u^(-u) $

C'est le modèle choisi pour le @complex car l'écart aux valeurs réels reste faible.

#columns(2)[
  #figure(caption: [Tracé de $rho(u)$ en fonction de $u$ \ Source : Wikipédia - Fonction de Dickman],image("../DickmanRho.png"))

  #colbreak()

  #figure(caption: [Tracé de $u^(-u)$ en fonction de $u$], image("../u^-u pour Dickman.png"))
]

// == Existence du point d'inflexion
//
// On utilise dans le @weierstrass l'existence d'un point d'inflexion de $E$ sans la prouver.
//
// On remarque que la preuve du @change n'utilise pas l'hypothèse de point d'inflexion directement, mais qu'elle transfère plutôt la propriété.
//
// On supose donc qu'un point $P$ admet pour tangente $Z = 0$.
