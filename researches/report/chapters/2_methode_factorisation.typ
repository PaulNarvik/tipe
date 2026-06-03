#import "@local/typst-packages:0.1.0": *
#import "@preview/theorion:0.6.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/cetz-plot:0.1.3": plot

#import cosmos.fancy: *

= La méthode de factorisation de Lenstra 

== Lissité

#definition[Lissité][
  Si $n$ est un entier et $n = product_(i=1)^m p_i^(alpha_i)$ sa décomposition en facteurs premiers, on dit que $n$ est *$B$-lisse* si pour tout $i in bracket.stroked 1; m bracket.r.stroked$, $p_i <= B$.

  On dit de même que $n$ est *$B$-superlisse* lorsque pour tout $i in bracket.stroked 1; m bracket.r.stroked$, $p_i^(alpha_i) <= B$.
]

== Algorithme de factorisation de Lenstra

Il s'agit d'une variante de l'algorithme $p - 1$ de Pollard exploitant les propriétés du corps fini $FF_p$.

#algorithm[Algorithme de Lenstra][
  Soient $n$ un entier, et $B$ une borne de lissité. On applique l'algorithme suivant pour trouver un facteur premier $p$ de $n$ à partir de courbes elliptiques $E_(a, b)$ de la forme :

  $ E_(a, b) : y^2 = x^3 + a x + b union cal(O) $

  - On vérifie que $n$ n'est divisible ni par $2$ ni par $3$ (on a alors trouvé un diviseur premier de $n$), pour s'assurer que $FF_p$ sera de caractéristique différente de $2$ ou $3$, et que $E_(a, b)(FF_p)$ sera donc bien définie.

  - On trouve tous les nombres premiers $p_1$, ..., $p_k <= B$.

  - On choisit une courbe elliptique $E_(a, b)$ modulo $n$ et un point $P eq.not cal(O)$ au hasard sur cette courbe.

  - On calcule $g$ le PGCD de $Delta = 4 a^3 + 27 b^2$ et $n$.

  - Si $g = n$, on change de courbe et de point.

  - Sinon si $g > 1$, c'est un facteur non trivial de $n$ que l'on renvoie.

  - Sinon, on calcule pour chacun des $p_i$ $e_i := floor((log B) / (log p_i))$ et $P <- p_i^(e_i)P$. Si ce calcul échoue, c'est que l'une des inversions nécessaires aux additions a échoué : on a trouvé un facteur.

  - Si aucune exception n'est levée lors de ces calculs, on change de courbe et de point ou on abandonne la factorisation.
]

Il peut être compliqué de trouver un point de manière aléatoire sur une courbe déjà choisie, on tire donc aléatoirement les coordonnées de $P$ et on calcule ensuite $b$ pour que $P$ soit un point de $E_(a, b)$.

#theorem[Choix optimal de B][
  Soit $n$ un entier avec un plus petit facteur premier $p$. Soit $B$ la borne optimale pour trouer $p$ à l'aide de l'algorithme de Lenstra.

  On suppose qu'une courbe elliptique modulo $p$ aléatoire de la forme $E_(a, b)$ où $4 a^3 + 27 b^2 equiv.not 0" "[p]$ a un cardinal $B$-lisse avec probabilité $u^(-u)$ où $u := (ln p) / (ln B)$.

  Si $L(x) := exp(sqrt(ln x dot ln ln x))$, alors $B = L(p)^(sqrt(2) / 2)$.

  De plus, le nombre total d'additions de points à effectuer pour trouver $p$ est $L(p)^sqrt(2)$, que l'on peut majorer pour tout facteur premier par $L(n)$.
]

#proof[
  L'équivalent asymptotique de la répartition des nombres premiers nous dit qu'il y a environ $B / (ln B)$ premiers inférieurs à $B$. La plupart vérifie $p^2 > B$ donc l'exposant nécessaire dans Lenstra est en général $1$.

  La multiplication rapide nécessite environ $log B$ additions. Donc un total de $B$ calculs par courbe.

  Par l'estimation précédente il faut donc essayer en moyenne $u^u$ courbes.

  On veut alors minimiser $f(B) = B u^u$.

  On prend $a$ tel que $B = L(p)^a$ et on exprime nos termes en fonction de ce paramètre :

  $ u ln u approx 1 / a sqrt((ln p) / (ln ln p)) 1/2 ln ln p = 1/(2a) ln L(p) $

  Donc $f(B) approx L(p)^(a + 1 / (2a))$ où $L(p)$ est une constante positive pour $p >= e^e$. Cette fonction est minimale pour $a = sqrt(2) / 2$.

  Donc $B = L(p)^(sqrt(2) / 2)$ et le nombre estimé d'opérations est $f(B) = L(p)^sqrt(2)$.

  Comme $p <= sqrt(n)$ pour tout facteur premier $p$ de $n$, on peut majorer par $L(N)$.
]

Dans la pratique, les valeurs de $B$ sont tabulées.
