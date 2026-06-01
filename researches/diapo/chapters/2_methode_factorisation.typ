#import "@local/typst-packages:0.1.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/theorion:0.6.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": plot

#import cosmos.fancy: *

= Méthode de Lenstra 

== Lissité

#definition[Lissité][
  Si $n$ est un entier et $n = product_(i=1)^m p_i^(alpha_i)$ sa décomposition en facteurs premiers, on dit que $n$ est  :

  - *$B$-lisse* si pour tout $i in bracket.stroked 1; m bracket.r.stroked$, $p_i <= B$.

  - *$B$-superlisse* si pour tout $i in bracket.stroked 1; m bracket.r.stroked$, $p_i^(alpha_i) <= B$.
]

---

== Algorithme de factorisation de Lenstra

#definition[
  On notera $E_(a, b)$ la courbe elliptique définie par :

  $ E_(a, b) : y^2 = x^3 + a x + b union cal(O) $ 
]

--- 

#algorithm[Algorithme de Lenstra][
  *Entrée* : un entier $n$ et une borne de lissité $B$.
  *Sortie* : un facteur premier $p$ de $n$.

  - On élimine naïvement tous les facteurs $2$ et $3$ de $n$ pour s'assurer que $FF_p$ sera de caractéristique différente de $2$ ou $3$, et que $E_(a, b)(FF_p)$ sera donc bien définie.

  - On trouve tous les nombres premiers $p_1$, ..., $p_k <= B$.

  - On choisit une courbe elliptique $E_(a, b)$ modulo $n$ et un point $P eq.not cal(O)$ au hasard sur cette courbe.
]

--- 

#{(algorithm-counter.update)((0, 1))}
#algorithm[Algorithme de Lenstra][
  - On calcule $g$ le PGCD de $Delta = 4 a^3 + 27 b^2$ et $n$.

    - Si $g = n$, on change de courbe et de point.
    - Sinon si $g > 1$, c'est un facteur non trivial de $n$ que l'on renvoie.

    - Sinon, on calcule pour chacun des $p_i$ $e_i := floor((log B) / (log p_i))$ et $P <- p_i^(e_i)P$. Si ce calcul échoue, c'est que l'une des inversions nécessaires aux additions a échoué : on a trouvé un facteur.

  - Si aucune exception n'est levée lors de ces calculs, on change de courbe et de point ou on abandonne la factorisation.
]

---

#remark[
  Il peut être compliqué de trouver un point de manière aléatoire sur une courbe déjà choisie, donc : 
  - On tire aléatoirement $a$.
  - On tire aléatoirement les coordonnées de $P$
  - On calcule $b$ pour que $P$ soit un point de $E_(a, b)$.
]

#remark[
  On utilise le crible d'Ératosthène pour récupérer les nombres premiers.
]

---

#assumption[
  On suppose qu'une courbe elliptique modulo $p$ aléatoire de la forme $E_(a, b)$ où $4 a^3 + 27 b^2 equiv.not 0" "[p]$ a un cardinal $B$-lisse avec probabilité $u^(-u)$ où $u := (ln p) / (ln B)$.

]

#theorem[Choix optimal de B][
  Soit $n$ est un entier avec un plus petit facteur premier $p$ et est $B$ la borne optimale pour trouver $p$ à l'aide de l'algorithme de Lenstra.

  Si $L(x) := exp(sqrt(ln x dot ln ln x))$, alors $B = L(p)^(sqrt(2) / 2)$.

  De plus, le nombre total d'additions de points à effectuer pour trouver $p$ est $L(p)^sqrt(2)$, que l'on peut majorer pour tout facteur premier par $L(n)$.
]

#remark[
  Dans la pratique, la valeur de $B$ est tabulée.
]
