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

def lcm(x, y)
	x * y / gcd(x,y)
end

def allfactor(x) #=> array
	candidate = (2..x/2).to_a
	candidate.select{|factor| x % factor == 0 }
end 
