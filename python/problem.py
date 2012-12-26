import support
import itertools 
def problem60():
	prime_list = support.prime(20000)
	
	def prime_set(n):
		if n <= 1:
			return dict.fromkeys( tuple((x,) for x in prime_list) )
		set_prev = prime_set(n-1)
		set_now = {}
		
		for set in set_prev.keys():
			for x in prime_list:
				ret = True
				for y in set:
					xy = int( "".join("%d"%i for i in (x, y)) )
					yx = int( "".join("%d"%i for i in (y, x)) )
					if not ( support.isprime(xy) and support.isprime(yx) ):
						ret = False
				if ret:
					set_now[set + (x,)] = None
		
		return set_now
	
	
	return prime_set(5)
	
	