require "problem.rb"

p = Problem.new()
t1 = Time.now
for n in (90..100)
	t1 = Time.now
	r = p.send("problem%d"%n)
	t2 = Time.now
	if r != :no_solve
		print "problem%d >> time:%f\tresult:%s\n"%[n, (t2-t1), r.to_s]
	end
end
t2 = Time.now

