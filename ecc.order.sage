#!/usr/bin/env sage

from itertools import groupby
from sage.all import *


if len(sys.argv) != 2:
    print("Usage: %s <n>" % sys.argv[0])
    print("Outputs the prime factorization of n.")
    sys.exit(1)

m = sage_eval(sys.argv[1])
orderL = []

Z = Zmod(m)
for a in range (m):
	temp = []
	for b in range (m):
		if ((4*a**3+27*b**2)%m > 0):
			E = EllipticCurve(Z, (a,b))
			temp.append(E.cardinality())
	print temp
	orderL+=temp

orderL = sorted(orderL)
t = [len(list(group)) for key, group in groupby(orderL)]


print t
