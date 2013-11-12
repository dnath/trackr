require "json"

file = open('users.json')
users_data = JSON.parse(file.read)
file.close

total = 0
total_new = 0
users = []
users_data['users'].each { |u|
	# puts u
	duplicate = false
	users.each { |u_new|
		if u_new['id'] == u['id']
			duplicate = true
			break
		end
	}

	if duplicate == false
		users << u
		total_new += 1
	end
	total += 1
}

# puts users

puts "total = " + total.to_s
puts "total_new = " + total_new.to_s

data = { :users => users}
puts JSON.pretty_generate(data)

file = open('test_users.json', 'w')
file.write(JSON.pretty_generate(data))
file.close

