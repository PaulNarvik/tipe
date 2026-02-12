import math
import random

class EllipticCurve:    
    def __init__(self, a : int, b : int, p : int):
        self.a = a
        self.b = b
        self.p = p

class EllipticPoint:
    def __init__(self, curve : EllipticCurve, x : int, y : int, infty : bool = False):
        self.curve = curve
        self.x = x
        self.y = y
        self.infty = infty

    def __add__(self, other):
        if other.infty:
            return self
        if self.infty:
            return other
        if self.x == other.x and self.y == other.y:
            # Point doubling
            m = (3 * self.x**2 + self.curve.a) * pow(2 * self.y, -1, self.curve.p) % self.curve.p
        else:
            # Point addition
            m = (other.y - self.y) * pow(other.x - self.x, -1, self.curve.p) % self.curve.p
        x_r = (m**2 - self.x - other.x) % self.curve.p
        y_r = (m * (self.x - x_r) - self.y) % self.curve.p
        return EllipticPoint(self.curve, x_r, y_r)
    
    def scalar_mul(self, k : int):
        result = EllipticPoint(self.curve, 0, 0, infty=True)
        addend = self
        while k:
            if k & 1:
                result += addend
            addend += addend
            k >>= 1
        return result
    
    def __str__(self):
        if self.infty:
            return "Point at Infinity"
        return f"({self.x}, {self.y})"
    
def calc_k(B):
    return math.lcm(B, B-1)

B_incr = 1
a_incr = 30
nb_essais = 40
x_init = 1
y_init = 1

def TrouveFacteur(n, B): 
    nouvelle_courbe=False;
    error = False;
    if ((n % 2) == 0):
        # Le facteur 2 a ete trouve
        #...
        return 2
    
    if ((n % 3) == 0):
        # Le facteur 3 a ete trouve
        return 3
    p = n
    k = calc_k(B)
    b = 1
    a = 1
    a_essais = 0
    P = EllipticPoint(EllipticCurve(a, b, p), x_init, y_init)
    while (1):
        b = (P.y * P.y) - (P.x * P.x * P.x) - (a * P.x);
        # PGCD(Delta, n) == 1 ?
        tmp = math.gcd(4 * a * a * a + 27 * b * b, n);
        while (tmp != 1):
            if (tmp == n):
                a += a_incr
                b = (P.y * P.y) - (P.x * P.x * P.x) - (a * P.x)
                tmp = math.gcd(4 * a * a * a + 27 * b * b, n)
            else:
                return tmp
        if (a_essais > nb_essais):
            nouvelle_courbe = True
        Q =  P.scalar_mul(k)
        # Lambda n’etait-il pas inversible ?
        if (error):
            g = math.gcd(Q.x, n)
            if(1 < g and g < n):
            # Impression des resultats
            # ...
                return g
            else:
                nouvelle_courbe = True
        # On change de courbe
        if (nouvelle_courbe):
            a = 1
            a_essais = 0
            B += B_incr
            while (k == calc_k(B)) :
                B += B_incr
            k = calc_k(B)
        else:
        # On incremente a
            a += a_incr
            a_essais += 1
        # Cette commande n’est jamais executee
        return 1

n = 8051
factor = []
while n > 1:
    d = TrouveFacteur(n, 10)
    if d is None:
        print("No factor found, retrying...")
        continue
    factor.append(d)
    n //= d