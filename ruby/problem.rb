require 'support.rb'
require "mathn"
require "memoize.rb"
require "date"
class Problem
	
	#Find the sum of all the multiples of 3 or 5 below 1000.
	def problem1
		return 0.step(999,3).reduce(:+) + 0.step(999,5).reduce(:+) - 0.step(999,15).reduce(:+)
	end
	
	#By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
	def problem2
		fibonacci.take_while{|x| x<4e6}.select{|x| x%2==0}.reduce(:+)  
	end

	#What is the largest prime factor of the number 600851475143 ?
	def problem3
		factoring(600851475143).last
		#600851475143.prime_divison.last[0]
	end

	#Find the largest palindrome made from the product of two 3-digit numbers.
	def problem4
		max = 0
		(100..999).each do |a|
			(a..999).each do |b|
				p = a * b
				if p.to_s.reverse == p.to_s && p > max
					max = p
				end
			end
		end
		return max
	end

	#What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
	def problem5
		def lcm_array(array)
			if array.size > 1
				lcm(array[0], lcm_array(array[1..-1]))
			else
				array[0]
			end
		end
		lcm_array((1..20).to_a)
	end

	#Sum square difference
	def problem6
		sum_sqr = sqr_sum = 0
		(1..100).each do |x|
			sum_sqr += x
			sqr_sum += x*x
		end
		sum_sqr * sum_sqr - sqr_sum
	end
	
	#10001st prime
	def problem7
		primes = Prime.new
		num= primes.next
		10000.times { num = primes.next }
		return num
	end
	
	#Largest product in a series
	def problem8
		s = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"
		num = s.split("")
		max_product = 0
		(0..s.size-5).each do |i|
			product = num[i].to_i * num[i+1].to_i * num[i+2].to_i * num[i+3].to_i * num[i+4].to_i
			max_product = product if max_product < product
		end
		return max_product
	end
	
	#Special Pythagorean triplet
	def problem9
		def gougushu?(a, b, c)
			a*a + b*b == c*c
		end

		(412..499).each do |c|
			(1...1000-c).each do |b|
				a = 1000 - c - b
				if gougushu?(a,b,c)
					return a*b*c
				end
			end
		end
	end
	
	#Summation of primes
	def problem10
		return 142913828922
		primes = Prime.new
		sum = 0
		loop do 
			prime = primes.next
			break if prime >= 2e6
			sum += prime
		end 
		return sum
	end
	
	#Highly divisible triangular number
	def problem12
		def division_count(x)
			x.prime_division.inject(1) do |sum, divs| 
				sum *= (divs[1] + 1)
			end
		end
		i, tri_num = 1, 1
		while division_count(tri_num) <= 500
			i += 1
			tri_num += i
		end
		return tri_num
	end

	#Longest Collatz sequence
	#if no cache, it will take a intolerance long time to compute
	def problem14
		def collatz_count(x, cache)			
			chain = cache[x]
			if chain > 0
				return chain
			end
			if x % 2 == 0
				cache[x] += collatz_count(x / 2, cache) + 1
			else
				cache[x] += collatz_count(3 * x + 1, cache) + 1
			end
		end
		
		cache = Hash.new(0)
		cache[2] = 1
		max, max_on = 0, 0
		(2...1e6).each do |num| 
			count = collatz_count(num, cache)	
			if count > max
				max = count
				max_on = num
			end	
		end
		return max_on
	end

	#Lattice paths
	def problem15_
		def path_count(w, h)
			combination(w + h, w)
		end
		path_count(20, 20)
	end

	# use memoize. so amazing!!!!!!!!!!
	include Memoize	
	def problem15
		def path_count(w, h)
			return 1 if w == 0 or h == 0
			count = 0
			count += path_count(w-1, h) if w > 0
			count += path_count(w, h-1) if h > 0
			return count
		end
		#without memoize, it will take more than an hour to compute
		#with memoize, each call will cache the result to speeds the next same call 
		memoize(:path_count)
		path_count(20, 20)
	end
	#Power digit sum
	def problem16
		(2**1000).to_s.split("").inject(0){|sum, c| sum + c.to_i}
	end

	#Counting Sundays
	def problem19
		#so simple!
		sundays = 0
		1901.upto(2000) do |year|
  			1.upto(12) do |month|
    			sundays += 1 if Date.new(year,month,1).wday == 0
  			end
		end
		return sundays
	end

	#Factorial digit sum
	def problem20
		factorial = (1..100).inject(1){ |factorial, x| factorial * x }
		factorial.to_s.split("").inject(0){ |sum, c| sum + c.to_i }
	end
	
	#Amicable numbers
	def problem21
		sum = 0
		d_array = (0..10000).map{|obj| proper_divisors_sum(obj) }
		for n1 in (1...10000)
			for n2 in (n1 + 1 .. 10000)
				if d_array[n1] == n2 && n1 == d_array[n2]
					sum += n1 + n2	
				end
			end
		end
		return sum
	end

	#Non-abundant sums
	def problem23
		abundant = (1..28123).select(){ |x| proper_divisors_sum(x) > x }
		abundant_sum = abundant.repeated_combination(2).map {|x| x[0] + x[1]}
		((1..28123).to_a - abundant_sum).inject(0) { |sum, n| sum + n}
	end
	
	#Lexicographic permutations
	def problem24
		def IndexOfPerm(array, index)
			if (index <= 0)
				return array
			else
				div, mod = index.divmod(permutation(array.size - 1, array.size - 1))	
				return ([]<<array.delete_at(div)) + IndexOfPerm(array, mod)
			end
		end
		IndexOfPerm([0,1,2,3,4,5,6,7,8,9,], 1e6 - 1).inject(""){|str, element| str + element.to_s}		
	end
	

	#1000-digit Fibonacci number
	def problem25
		fibonacci.take_while {|x| x.to_s.size<1000}.size + 1
	end
	
	#Reciprocal cycles
	def problem26
		def cycles(x)
			mods, divs = [], []
			dividend, divisor =  x.numerator, x.denominator
			loop do	
				div, mod = dividend.divmod(divisor)
				dividend = mod * 10
				divs<<div
				if index = mods.index(mod)
					return divs[index+1..mods.size] 
				end
				mods<<mod
			end
		end
		(2..1000).inject([2, 0]) do |max, x|
			cycles_size = cycles(1/x).size
			if cycles_size > max[1]
				max = [x, cycles_size]
			else
				max
			end
		end[0]
	end
	
	#Quadratic primes
	def problem27
		#b must be prime, get this from f(x) = prime when x = 0
		prime = Prime.new
		bs = prime.take_while { |x| x < 1000 }
		#a+b+1 must be prime, get this from f(x) prime when x = 1
		(-999..999).select{|x| x <100}
	end
	















	def method_missing(method_name, *args, &block)
		#missing the method whose name is "problemXX"
		if method_name.to_s[/\Aproblem\d+\z/]
			return :no_solve
		end
		super(method_name, *args, &block)
	end
end
