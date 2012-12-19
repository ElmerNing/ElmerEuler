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
   		a = 1; b = 2;
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
	a, b = r, n-r
	(a+1..n).inject(1) { |t,v| t*v}
end

def combination(n, r) # => Interger
	a, b = r, n-r
  	denom = (2..b).inject(1) { |t,v| t*v }    # (n-r)!
  	permutation(n, r) / denom
end

def proper_divisors(x) # => Array
	divisors = [1]	
	(2..x/2).each{ |n| divisors << n if x % n == 0 }
	return divisors
end 

def sum_of_proper_divisors(x)
	
end

