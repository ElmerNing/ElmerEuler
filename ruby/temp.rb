require "support"
def problem75
	limit = 1500000
	result = 0
	mlimit = (limit**0.5).to_i
	abc = Array.new(limit+1){|index| 0}
	for m in (2..mlimit)
		for n in (1...m)
			if (m+n)%2 == 1 and gcd(m,n) == 1
				p = 2*m*(m+n)
				pk = p	
				while pk < limit
					abc[pk] += 1
					result+=1 if abc[pk] == 1
					result-=1 if abc[pk] == 2
					pk += p	
				end
			end	
		end
	end
	return result
end

def problem76
	num = 1000
	cache = Array.new(num + 1)
	cache[0] = Array.new(0 + 1){|index| 1}
	for n in (1..num)
		cache[n] = Array.new(n+1)
		cache[n][0] = 0
		for i in (1..n) #i is the first addend
			remain = n-i
			remain_limit = i < remain ? i : remain
			cache[n][i] = cache[n][i-1] + cache[remain][remain_limit]
		end
	end
	return cache[num][num] - 1 #delete only one addend situation
end

def problem76_new
	limit = 100
	cache = Array.new(limit + 1)
	for i in cache
		i = Array.new(limit + 1){|index| = 0}	
	end
	for n in (1..limit)		
		for m in (n..limit)
			cache[m] = 
		end
	end 
end

def problem408
	#combination(2000000,1000000)
end

print problem77, "\n"



