(1..100).to_a.each do |num|

	if num % 3 == 0 and num % 5 == 0
		puts "fizzbuzz"
	elsif num % 3 == 0 and num % 5 != 0
		puts "fizz"
	elsif num % 5 == 0 and num % 3 != 0
		puts "buzz"
	else
		puts num
	end
end
