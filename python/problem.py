import support
import itertools 
def problem60():
	prime_list = support.prime(1000)
	
	def prime_set(n):
		if n <= 1:
			return dict.fromkeys( tuple((x,) for x in prime_list) )
		set_prev = prime_set(n-1)
		set_now = {}
		
		for set in set_prev.keys():
			ret = True
			for x in prime_list:
				for y in set:
					xy = int( "".join("%d"%i for i in (x, y)) )
					yx = int( "".join("%d"%i for i in (y, x)) )
					if not ( support.isprime(xy) and support.isprime(yx) ):
						ret = False
			print ret, len(set)
			if ret:
				print set + (x,)
		#return set_n
	
	prime_set(2)
	return 0
	
	