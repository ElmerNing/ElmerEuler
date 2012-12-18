require 'problem'
puts a=true
p = Problem.new()

t1 = Time.now
(1..400).each do |n|
	t1 = Time.now	
	r = p.send("problem%d"%n)
	t2 = Time.now
	if r != :no_solve
		print "problem%d >> time:%f\tresult:%s\n"%[n, (t2-t1), r.to_s]
	end
end
t2 = Time.now
