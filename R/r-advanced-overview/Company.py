class Company():
    def __init__(self, HC, EBIT):
        self.HC = HC
        self.EBIT = EBIT
    def __add__(self, other):
        return Company((self.HC+other.HC)*0.8 ,(self.EBIT + other.EBIT)*1.2)
    def __repr__(self):
        out="HC: %s, EBIT: %s"%(self.HC,self.EBIT)
        return out

# a few calls:
# Microsoft = Company(50, 95)
# LinkedIn = Company(2, 5)
# Microsoft + LinkedIn 
