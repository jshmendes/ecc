#!/usr/bin/env sage

from numpy import median
from itertools import groupby
from sage.all import *


'''
Naive implemenation of ECM method
for test and education purposes
'''
def factorECM(k,m,verbose):
	condition1 = True
	condition2 = True
	Z = Zmod(m)
	curvecount = 0
	x = 0
	y = 1
	while curvecount < 10000: 
		#We generate some random parameters to get a Curve
		a = ZZ.random_element(0,m)	
		b = ZZ.random_element(0,m)
		#We make sure we generating a valid EC curve
		if ((4*a**3+27*b**2)%m > 0):
			curvecount += 1
			#The curve is defined modulo M
			E = EllipticCurve(Z, (a,b))
			if(verbose):
				print "Curve", a ,b 
			'''For some reasons, Sage does not allow us to
			use E.random_point() when M is composite
			so we have to compute a point on the curve
			We simply try various value of x and hope to find one  		
			'''		
			while condition2 :
				x = ZZ.random_element(0,m)
				y2 = x**3 + a*x + b % m
				try:			
					y = mod(y2,m).sqrt(extend=False) 		
				
				except:
					continue
				break	
			
			P = E(x,y)
			#We compute k*P	on catch the error if any, if not we'll try another curve	
			try:
				Q = k*P
			except ZeroDivisionError as err:
				d = Integer(err.args[0].split()[2])
				if(verbose):
					print "After testing ", curvecount, " curve(s), we have a winner : "
					print "\t Point P :"  , P
					print "\t on E(",a,",",b,")"			
					print "\t In K*P computation, d=", d ,"has no inverse modulo", m  
					print "\t So we found one factor gcd(m,d) =", gcd(m,d)
				print "m =", m , " = ", gcd(m,d),"x", m/gcd(m,d)
				return curvecount

	if(verbose):
		print "No factor found with the given parameter : try increase B"
	return curvecount

def main(argv):		
	if len(sys.argv) != 4:
	    print("Usage: %s <v|q> <Number> <Smooth Border>  " % sys.argv[0])
	    print("Naive implementation of ECM for factorization")
	    print("v : Try to factor <Number> with <Smooth Border>")
	    print("q : Do some benchmark with random composite and predefine B")

	    sys.exit(1)

	#The number we want to factor
	m = sage_eval(sys.argv[2])

	#super-smooth border B
	B = sage_eval(sys.argv[3])

	if sys.argv[1] == 'v':
		#We compute the number k
		k = LCM(2..previous_prime(B))
		factorECM(k,m,True)
		return 0
	if sys.argv[1] == 'q':
		Blist = (200,500,1000,1500)
		for i in range (11,16):
			rg = 10**i
			for B in Blist:		
				nbcurve = list()
				k = LCM(2..previous_prime(B))
				for l in range(10):
					p = next_prime(ZZ.random_element(rg,rg*10))
					q = next_prime(ZZ.random_element(rg*321,rg*14311))
					nbcurve.append(factorECM(k,p*q,False))
				print rg, B,  
				print float(sum(nbcurve) / len(nbcurve)), float(median(nbcurve)),
				print nbcurve

if __name__ == "__main__":
   main(sys.argv[1:])

