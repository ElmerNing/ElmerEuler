require "problem.rb"

def factoring(num, start = 2) # => Array
	candidate = (start..Math.sqrt(num).to_int).to_a
	factors = Array.new
	if index = candidate.index{ |x| num % x == 0 }
		factors << candidate[index]
		factors += factoring(num/candidate[index],candidate[index])
	else
		factors << num
	end
	return factors
end
	
def fibonacci # => Enumerator
	Enumerator.new { |y|
		a = 1; b = 1;
		loop {
			y << a
			a, b = b, a + b 
		}
	}
end

def gcd(x, y) # => Interger
   y == 0 ? x : gcd(y, x % y)
end

def lcm(x, y) # => Interger
	x * y / gcd(x,y)
end

def permutation(n, r) # => Interger
	(n-r+1..n).inject(1) { |t,v| t*v}
end

def combination(n, r) # => Interger
  	denom = (2..r).inject(1) { |t,v| t*v }    # (n-r)!
  	permutation(n, r) / denom
end

def proper_divisors(x) # => Array
	divisors = [1]	
	(2..x/2).each{ |n| divisors << n if x % n == 0 }
	return divisors
end 

def proper_divisors_sum(x)
	proper_divisors(x).inject(0) {|sum, x| sum + x}
end

def primes(lowto, upto)
	#Eratosthenes screening method
	isprime = Array.new(upto + 1) {|index| true}
	isprime[0], isprime[1] = false, false
	for i in (2..upto)
		next if not isprime[i]
		(i+i).step(upto, i).each do |j|
			isprime[j] = false
		end
	end
	(lowto..upto).select { |x| isprime[x] }
end

def ppt() # => Array
	#generator primitive  pythagorean triple 
	#http://mathworld.wolfram.com/PythagoreanTriple.html
	v = [[3,4,5]]
	u = Matrix[[1,2,2], [-2,-1,-2], [2,2,3]]
	a = Matrix[[1,2,2], [2,1,2], [2,2,3]]
	d = Matrix[[-1,-2,-2], [2,1,2], [2,2,3]]
	
	y = []
	loop do
		break if v.length == 0
		y += v
		v =v.inject([]) do |news, org|
			[u,a,d].each do |m|
				new = Matrix[org] * m
				row = new.to_a[0].sort
				if yield(row[0],row[1],row[2])#new.row(0).max <= max
					news << row
				end
			end
			news
		end
	end
	y.sort_by {|obj| obj[2]}
end