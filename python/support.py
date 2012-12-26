import math
import numpy
def prime(upto):
    primes=numpy.arange(3,upto+1,2)
    isprime=numpy.ones((upto-1)/2,dtype=bool)
    for factor in primes[:int(math.sqrt(upto))]:
        if isprime[(factor-2)/2]: isprime[(factor*3-2)/2::factor]=0
    return numpy.insert(primes[isprime],0,2)

def isprime(n):
	max = math.sqrt(n)
	if n == 2:
		return True
	if n%2 == 0:
		return False
	d = 3
	while n%d != 0 and d <= max:
		d += 2
	return d > max