'''
Just for fun
'''

import math
import sys, getopt
from fractions import gcd
from itertools import groupby


'''
Return a list for a Elliptic curve
with parameter y2 = x**3+a*x+b % mod
We first compute the list of i such as i^2 = y % mod
in order to find easily if y^2=f(x) has a solution 
'''

def listpoint(a,b,mod):
	res = list()
	output = list()
	for i in range (mod) :
		y2 = i**2 %mod
		res.append(y2)

	for j in range(mod):
		y2 = (j**3+a*j+b)%mod
		if y2 in res:
			indices = [i for i, x in enumerate(res) if x == y2]
			for i in range (len(indices)):
				output.append((j, indices[i]))
	return output

'''
Provide range for the order of curve 
using Hasse's theorem
'''
def orderC(mod):
	return (int(mod-2*math.sqrt(float(mod))+1),int(mod+2*math.sqrt(float(mod))+1))

'''
Basic primality test 
'''
def isPrime(n):
    for i in range(2,int(n**0.5)+1):
        if n%i==0:
            return False
    return True

'''
We compute the product all prime p**i such as
i is the max to verify p**i < B 
=> Stupid version as it will blow the memory if B is too big
'''
def supersmoothValue(B):
    Bss = 1
    for i in range(2,B):
	if isPrime(i):
		j = i
		power = 0
		while j < B:
			power +=1
			j = j*i
		Bss = Bss*i**power
    return Bss


''' 
Return 1 if val divide Bss
'''
def supersmoothTestV1(val,Bss):
	if gcd(val,Bss) == val:
		return 1
	else:
		return 0

'''
 Smarter version of the above computation
Instead of computing Bss as the product of all p^i
We compute it as list of all p^i. 
'''
def superSmoothList(B):
    Bss = list()
    for i in range(2,B):
	if isPrime(i):
		j = i
		power = 0
		while j < B:
			power +=1
			j = j*i
		Bss.append(i**power)
    return Bss


'''
For each p^i, We compute the gcd(p^i, val)
and return the product of the gcd
if gcd == val, val divide Bss
'''

def supersmoothTestV2(val,Bss):
	res = 1
	for i in Bss:
		res = res*gcd(i,val)
	if res == val:
		return 1
	else:
		return 0

'''
Small function to find Bss-Smooth orders of EC
'''
def supersmoothTest((a,b),Bss):
    res = list()
    for i in range (a,b+1):
	if supersmoothTestV2(i,Bss) == 1:
		res.append(i)
    return res

#Compute the number of elements for each curve modulo m (m must be prime).
# and count the number of curve by order.
#This dummy implementation is actually faster than using sage for small value of m
def computeCurveOrder(m):
   	orderL = []
   	count = 0	
	for a in range (m):
		for b in range (m):
			if ((4*a**3+27*b**2)%m > 0):
				orderL.append(len(listpoint(a,b,m))+1)
				count+=1

	orderL = sorted(orderL)
	t = [len(list(group)) for key, group in groupby(orderL)]
	return t	


def main(argv):
   a = ''
   b = ''
   m = ''
   try:
      opts, args = getopt.getopt(argv,"ha:b:m:",["a=","b="])
   except getopt.GetoptError:
      print 'ecc.py -a <a> -b <b> -m <modulo>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'ecc.py -a <a> -b <b> -m <modulo>'
         sys.exit()
      elif opt in ("-a", "--a"):
         a = arg
      elif opt in ("-b", "--b"):
         b = arg
      elif opt in ("-m", "--modulo"):
         m = int(arg)



   #res =  listpoint(int(a),int(b),int(m)) 
   #we had one : to have the neutral element (the infinity)
   #print len(res)+1
   #print res
   cond0 = True
   cond1 = False
   cond2 = False
   cond3 = False


   if(cond0):
	for i in range(m):
		Bss = supersmoothValue(i)
		print Bss
   if(cond1):
	   listOfVal = (17,53,79,101,127,173,257,727)
	   for m in listOfVal:	   
		   t = computeCurveOrder(m)
		   print m, t, len(t), 2*int(2*math.sqrt(float(m)))+1
		   count = 0 
		   for i in t:
			count +=i
		   orderRange = orderC(int(m))
		   split = orderRange[1] -  orderRange[0]
		   print m, count, count / len(t), orderRange, split
	
   if(cond2):
	   listOfVal = (11,101, 1009,10009,100003,1000003,10000019,100000007,1000000007,10000000019)
	   for m in listOfVal:	
		   orderRange = orderC(int(m))
		   split = orderRange[1] -  orderRange[0]
		   print m, orderRange, split, 
		   Bss = superSmoothList(int(m**0.5))
		   NbSmooth = len(supersmoothTest(orderRange,Bss))
		   print NbSmooth, float(NbSmooth)/split

	   for i in range(3,int(m**0.25)):
	   	Bss = superSmoothList(i)
		if Bssold == Bss :
			continue
		Bssold = Bss
	   	print len(supersmoothTest(orderRange,Bss)),

	  


if __name__ == "__main__":
   main(sys.argv[1:])

