#class Support

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

def primes(upto)
	prime_list = []
	Prime.new.each do |x|
		break if x > upto			
		prime_list << x
	end
	return prime_list
end

