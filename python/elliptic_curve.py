class EllipticPoint:
    def __init__(self, x : int, y : int, infty : bool):
        self.x = x
        self.y = y
        self.infty = infty

    def __add__(self, p):

