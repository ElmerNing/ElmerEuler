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
		bs =bs  + bs.map{ |x| x * -1 }
		max_n, max_a, max_b = 0, 0, 0
		for b in bs
			for a in -1999.step(1999,2)
				n = 0
				while prime.prime?(n*n + a*n + b)
					n+=1
				end
				if n > max_n
					max_n, max_a, max_b = n, a, b
				end
			end
		end
		max_a * max_b
	end
	
	#Number spiral diagonals
	def problem28
		sum, n, step = 1, 1, 2
		500.times do |i|
			4.times do |j|
				n += step
				sum += n
				#puts n
			end
			step += 2
		end
		sum
	end
	
	#Distinct powers
	def problem29
		pows = []
		for a in (2..100)
			for b in (2..100)
				pows << a**b
			end
		end
		pows.uniq.sort.size
	end
	
	#Digit fifth powers
	def problem30
		powers = []
		for x in (2..1e6)
			nums = x.to_s.split("")
			if x == nums.inject(0){ |sum, x| sum + x.to_i**5 }
				powers << x
			end
		end
		fifthpowers.inject(0) {|sum, x| sum + x}
	end
	
	#Coin sums	
	def problem31
	if false
		#Dynamic programming without optimzing
		target = 200
		coins = [1,2,5,10,20,50,100,200]
		ways = [Array.new(coins.size, 1)]
		target.times do 
			array = Array.new(coins.size, 0)
			array[0] = 1 
			ways << array
		end
		
		#ways[m][i] indicate the number of ways to make m using coins[0..i]
		for i in (1...coins.size)
			coin = coins[i]
			for m in (0..target)
				if m < coin
					ways[m][i] = ways[m][i-1]
				else
					ways[m][i] = ways[m][i-1] + ways[m-coin][i]
				end
			end
 		end		
		return ways[200][coins.size-1]
	else	
		#optimizing alg
		#be aware of ways[m][i-1] is used only by ways[m][i], so we can merge ways[m][i-1] by accmulation
		target = 200
		coins = [1,2,5,10,20,50,100,200]
		ways = [1] + [0] * target
		for coin in coins
			for i in (coin..target)
				ways[i] += ways[i-coin]
			end
		end
		ways[target]
	end
	end
	
	#Pandigital products
	def problem32
		xy = []
		(2..100).each do |x|
			(x..9999/x).each do |y|
				if ("%d%d%d"%[x,y,x*y]).split("").sort.join.eql?("123456789")
					xy << (x * y)
				end
			end
		end
		xy.uniq.reduce(:+)
	end
	
	#Digit canceling fractions
	def problem33
		non_trivial = []
		(1..9).each do |x|
			(1...x).each do |y1|
				(y1..9).each do |y2|
					y1x, xy2 = y1*10 + x, x*10 + y2
					if y1x / xy2 == y1 / y2
							non_trivial << y1x / xy2
					end
				end
			end
		end	
		non_trivial.inject(:*).denominator
	end
	
	#Digit factorials
	def problem34
		curious  = []
		factorial = (0..9).map{|x| x==0 ? 1 : (1..x).inject(:*)}
		(3...100000).each do |xx|
			sum = xx.to_s.split("").inject(0) do |sum, x|
				sum += factorial[x.to_i]
			end
			if sum == xx
				curious << xx
			end
		end
		curious.inject(:+) 
	end
	
	#Circular primes
	def problem35
		prime_enum = Prime.new
		primes, circular = Hash.new(false), []
		
		while (prime = prime_enum.next) < 1e6
			primes[prime] = true
		end
		
		primes.each_key do |x|
			s = x.to_s
			is_circular = true
			while (s = s[-1,1] + s[0..-2]) != x.to_s
				if not primes[s.to_i]
					is_circular = false
				end
			end
			circular << x if is_circular
		end
		circular.size
	end
	
	#Double-base palindromes
	def problem36
		pals = []
		#(1..1e6).each do |x|
		#	dec = x.to_s
		#	bin = "%b"%x
		#	if dec == dec.reverse and bin == bin.reverse
		#		pals << x
		#	end
		#end
		
		#optimizing
		(1..999).each do |x|
			s = x.to_s
			rs = s.reverse
			
			pal1 = (s + rs).to_i
			pal2 = (s + rs[1..-1]).to_i
			
			bin_pal1 = "%b"%pal1
			bin_pal2 = "%b"%pal2
			
			if bin_pal1.reverse.eql?(bin_pal1)
				pals << pal1
			end
			if bin_pal2.reverse.eql?(bin_pal2)
				pals << pal2
			end
		end
		pals.inject(:+)
	end
	
	#Truncatable primes
	def problem37
		def truncatable?(x)
			s = x.to_s
			count = s.size
			for i in (1...count)
				return false if not s[i..-1].to_i.prime?
				return false if not s[0..-1-i].to_i.prime?
			end
			return true
		end
		
		truncat = []
		prime = Prime.new
		4.times{prime.next}
		loop do
			break if truncat.size >= 11
			x = prime.next
			truncat << x if truncatable?(x)
		end
		truncat.inject(:+)
	end
	
	#Pandigital mutiples
	def problem38
		pandigitals = []
		for x in (1..10000)
			pandigital = ''
			for n in (1..10)
				pandigital += (n*x).to_s
				break if pandigital.size >= 9
			end
			if pandigital.size == 9 and pandigital.split("").sort.join == "123456789"
				pandigitals << pandigital.to_i
			end
		end
		pandigitals.sort[-1]
	end
	
	#Integer right triangles
	def problem39
		right_tri = Hash.new(0)
		for a in (1..1000)
			for b in (a..1000-a)
				c = Math.sqrt(a*a + b*b)
				if c.class == Fixnum && a+b+c <= 1000
					right_tri[a+b+c] += 1
				end
			end
		end
		max, max_p = 0
		right_tri.each do |key, value|
			if value > max
				max = value
				max_p = key
			end
		end
		return max_p
	end
	
	#Champernowne's constant
	def problem40
		def digit_at(n)
			digits = 1
			n = n - 1
			while true
				numbers = 9 * (10**(digits-1)) * digits
				if n > numbers
					n = n - numbers
				else
					break
				end
				digits = digits + 1
			end
			
			num = n.div(digits) + (10**(digits-1))
			return num.to_s[n%digits].to_i
		end
		digit_at(1) * digit_at(10) * digit_at(100) * digit_at(1000) * digit_at(10000) * digit_at(100000) * digit_at(1000000)
	end
	
	#Pandigital prime
	def problem41
		andigitals = (1..7).to_a.permutation(7).each.map { |x| x.join.to_i }.sort!.reverse
		max = 0
		andigitals.each do |x|
			if x.prime?
				return x
			end
		end
		return 0
	end
	
	#Pentagon numbers
	def problem45
		max = 60000
		t = (1..max).to_a.map{|x| x*(x+1)/2}
		p = (1..max).to_a.map{|x| x*((3*x)-1)/2}
		h = (1..max).to_a.map{|x| x*((2*x)-1)}
		(t & p & h)[2]
	end
	
	#Goldbach's other conjecture
	def problem46
		max = 6000
		sqr_hash = {}
		(1..Math.sqrt(max)).each{ |x| sqr_hash[x*x] = nil }
		
		prime_list = []
		Prime.new.each do |x|
			break if x > max			
			prime_list << x
		end
		
		3.step(6000,2).each do |x|
			next if x.prime?
			goldbach = false
			prime_list.each do |prime|
				break if prime > x
				goldbach = true if sqr_hash.has_key?((x-prime)/2)
			end
			return x if not goldbach
		end
		return 0
	end
	
	#Distinct primes factors
	def problem47
		x1,x2,x3,x4 = 644, 645, 646, 647
		f1,f2,f3,f4 = factoring(x1).uniq, factoring(x2).uniq, factoring(x3).uniq, factoring(x4).uniq
		loop do
			x1,x2,x3,x4 = x2, x3, x4, x4+1
			f1,f2,f3,f4 = f2, f3, f4, factoring(x4).uniq
			if f1.size == 4 and f2.size == 4 and f3.size == 4 and f4.size == 4
				return [x1,x2,x3,x4]
			end
		end
	end
	
	#Self powers
	def problem48
		sum = (1..1000).to_a.inject(0){|sum, x| sum + x**x}
		sum.to_s[-10,10]
	end
	
	#Prime permutations
	def problem49
		(1..9).to_a.repeated_combination(4).each do |x|
			ps = []
			x.permutation(4).each do |p|
				p = p.join.to_i
				if (!ps.include?(p)) and p.prime?
					ps << p
				end
			end
			
			next if ps.size < 3
			ps.sort
			
			ps.combination(3).each do |ppp|
				if ppp[1]-ppp[0] == ppp[2] - ppp[1] and ppp[0] != 1487
					return ppp.join
				end
			end
		end
		return nil
	end
	
	#Consecutive prime sum
	def problem50
		prime_list = []
		Prime.new.each do |x|
			break if x > 1e6		
			prime_list << x
		end
		1000.step(1,-1) do |n|
			(0..prime_list.size-n).each do |start|
				sum = prime_list[start, n].inject(:+)
				break if sum > 1e6
				return sum if sum.prime?
			end	
		end
	end
	
	#Prime digit replacements
	def problem51
		def index_of(array, v)
			return array.each_index.inject([]) do |index_of, index|
				if array[index] == v
					index_of << index
				end
				index_of
			end
		end
		
		def take_while_prime(array, replace_index, replace_values)
			#just replacing replace_index get the right answer
			#replace all the subset of replace_index to be more strict
			ret = []
			replace_values.each do |value|
				new_array = Array.new(array)
				replace_index.each { |index| new_array[index] = value }
				new_value = new_array.join.to_i
				ret << new_value if new_value.prime?
			end
			return ret
		end
		
		def replace_prime?(prime)	
			split = prime.to_s.split("").map{ |x| x.to_i }
			index_of_x = {}
			index_of_x[0] = index_of(split, 0)
			index_of_x[1] = index_of(split, 1)
			index_of_x[2] = index_of(split, 2)
			
			(0..2).each do |n|
				next if index_of_x[n].size == 0
				replace_values = (n+1.. 9)
				ret = take_while_prime(split, index_of_x[n], replace_values)
				return true if ret.size >= 7
			end
			return false
		end

		prime = Prime.new
		x = 0
		loop do
			x = prime.next
			break if replace_prime?(x)
		end
		x
	end
	
	#
	def problem52
		n = 1
		loop do
			all = [n, n*2, n*3, n*4, n*5, n*6]
			all = all.map{ |x| x.to_s.split("").sort! }
			if all[0] == all[1] and all[1] == all[2] and all[2] == all[3] and all[3] == all[4] and all[4] == all[5]
				return n
			end
			n += 1
		end
	end
	
	#Combinatoric selections
	def problem53
		num = 0
		for n in (23..100)
			for r in (2..n-2)
				x = combination(n, r)
				num += 1 if x > 1e6
			end
		end
		return num
	end
	
	#Lychrel numbers
	def problem55
		def reverse(x)
			return x.to_s.split("").reverse.join.to_i
		end
		num = 0
		(1..10000).each do |x|
			lychrel = true
			for i in (1..50)
				x = x + reverse(x)
				if x == reverse(x)
					lychrel = false
					break
				end
			end
			num += 1 if lychrel
		end
		num
	end
	
	#Powerful digit sum
	def problem56
		max = 0
		for a in (10..100)
			for b in (10..100)
				pow = a**b
				sum = pow.to_s.split("").inject(0){ |sum, x| sum + x.to_i }
				max = sum if sum > max
			end
		end
		return max
	end

	#Square root convergents
	def problem57
		fractions = []
		fractions << (1+1/2)
		for i in (1..999)
			fractions << ( 1 + 1 / (1 + fractions[-1]) )
		end
		#fractions.each do |x|
		#	print x.numerator.to_s.split(""), "\n"
		#	print x.denominator.to_s.split(""), "\n"
		#end
		fractions.inject(0) do |count, x|
			if x.numerator.to_s.split("").size > x.denominator.to_s.split("").size
				count += 1
			end
			count
		end
	end
	
	#Spiral primes
	def problem58
		total, prime, n, step = 1, 0, 1, 2
		#primes = []
		loop do
			4.times do |j|
				n += step
				prime += 1 if n.prime?
			end
			total += 4
			step += 2
			break if prime * 10 < total
		end
		step-1
	end

	#XOR decryption
	def problem59
		codes = File.read("cipher1.txt").chomp.split(",").map{|x| x.to_i}
		
		key_len = 3
		('a'..'z').to_a.repeated_permutation(key_len).each do |abc|	
			
			key = abc.join.bytes.map{|x| x}
			
			decodes_asii = codes.each_index.map { |index| codes[index] ^ key[index % key_len] }
			
			decodes = decodes_asii.inject("") do |decodes, c|
				decodes + c.chr
			end
			
			if decodes.include?(" the ")
				return decodes_asii.inject(:+)
			end
		end
	end
	
	#Prime pair sets
	def problem60
		def prime_set(n, prime_list)		
			if n == 1
				return prime_list.map{ |x| [x] }
			end	
			set_n_1 = prime_set(n-1, prime_list)
			set_n = []
			set_n_1.each do |set|
				prime_list.each do |x|
					ret = true
					set.each do |y|
						next if [x,y].join.to_i.prime? and [y,x].join.to_i.prime?
						ret = false
						break
					end
					if ret
						set_n << (Array.new(set) << x)
					end
				end
			end		
			set_n.each do |x|
				x.sort!
			end
			set_n.uniq
		end	
		prime_list = []
		Prime.new.each do |x|
			break if x > 20000			
			prime_list << x
		end
		
		prime_set(5, prime_list)
	end


	def method_missing(method_name, *args, &block)
		#missing the method whose name is "problemXX"
		if method_name.to_s[/\Aproblem\d+\z/]
			return :no_solve
		end
		super(method_name, *args, &block)
	end
end
