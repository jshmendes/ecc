#!/usr/bin/env sage

from itertools import groupby
from sage.all import *

'''
Sage implementation of the order repartition computation 
for all valid simple Weierstrass Elliptic Curve
Actually a bit slower than my implementation
'''

if len(sys.argv) != 2:
    print("Usage: %s <n>" % sys.argv[0])
    print("Outputs the number of curve modulo <n> with same order for all possible orders")
    sys.exit(1)

m = sage_eval(sys.argv[1])

if( is_prime(m) == False):
	print("The input number must be prime!")
	sys.exit(1)


orderL = []


Z = Zmod(m)
for a in range (m):
	temp = []
	for b in range (m):
		#make sure curve is valid
		if ((4*a**3+27*b**2)%m > 0):
			E = EllipticCurve(Z, (a,b))
			temp.append(E.cardinality())
	#print temp
	orderL+=temp

orderL = sorted(orderL)
t = [len(list(group)) for key, group in groupby(orderL)]

# print Output List
 
print t
