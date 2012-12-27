def primes(n):
    # http://stackoverflow.com/questions/2068372/fastest-way-to-list-all-primes-below-n-in-python/3035188#3035188
    """ Returns  a list of primes < n """
    sieve = [True] * (n/2)
    for i in xrange(3,int(n**0.5)+1,2):
        if sieve[i/2]:
            sieve[i*i/2::i] = [False] * ((n-i*i-1)/(2*i)+1)
    return [2] + [2*i+1 for i in xrange(1,n/2) if sieve[i]]

def isprime(x,ps):
   if x < 2: return False
   maxp = int(x**0.5)
   for p in ps:
      if x%p == 0: return False
      if p > maxp: return True

cc = {}
def concats(a):
   if a not in cc:
      cc[a] = set()
      a_i = ps.index(a)
      a_str = str(a)
      for b_i in xrange(a_i,len(ps)):
         b = ps[b_i]
         b_str = str(b)
         ab,ba = int(a_str+b_str),int(b_str+a_str)
         if isprime(ab,ps) and isprime(ba,ps):
            cc[a].add(b)
   return cc[a]

def concat(d,ns,concats_n):
   for n in concats_n:
      concat(d-1,ns+[n],concats_n&concats(n))
   if d==0: print ns,sum(ns)

ps = primes(10000)
concat(5,[],set(ps))


