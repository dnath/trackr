# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Goal.delete_all
User.delete_all
GoalInstance.delete_all

n_gi = 180 # 10000
n_g  = 18 # 110
n_u  = 33 # 1300

#####################################################
goal_instances = []
goal_instances_flag = []

for i in 0..n_gi-1
	st = Date.today - rand(30)
	et = st + rand(45)
	complete = false
	if et > Date.today
		complete = true
	end
	goal_instance = GoalInstance.create(
		{ start_date: st, end_date: st + rand(30), cheer_ons:rand(n_u/2), is_complete: complete},
	)
	goal_instances.push(goal_instance);
	goal_instances_flag << false
end

puts "goal_instances.length = " + goal_instances.length.to_s

##########################################

file = open('db/goals.json')
goals_data = JSON.parse(file.read)
file.close

goals = []
s_idx = 0
goals_data['goals'].each { |g|
	# puts g
	n = rand(n_gi/n_g) # ~ 10000/100

	puts "n = " + n.to_s
	puts "s_idx = " + s_idx.to_s

	gi = []
	for i in 0..n
		if i+s_idx >= n_gi
			puts "** i + s_idx = " + (i+s_idx).to_s
			break
		end
		gi << goal_instances[i+s_idx]

		if gi.length == 1
			goal_instances_flag[i+s_idx] = true
		end
	end
	
	s_idx += n+1
	# puts "gi = " + gi.to_s
	
	goal = JSON.parse(g.to_json)
	goals.push(
		Goal.create(
			{ title:goal["title"], description: goal["description"], picture: goal["picture"],
				goal_instances: gi }
		)
	)
}

if s_idx < n_gi
	puts "## s_idx = " + s_idx.to_s
	g = goals.last.goal_instances
	for i in s_idx..n_gi-1
		g << goal_instances[i]
	end
	goals.last.goal_instances = g
	goals.last.save
end

puts "goals.length = " + goals.length.to_s

file = open('db/test_users.json', 'r')
users_data = JSON.parse(file.read)
file.close

i = 0
j = 0
users_data['users'].each { |u|
	# puts u
	puts "i = " + i.to_s
	puts "j = " + j.to_s

	g = []
	gi =[]
	# if i < n_g
	# 	g = [goals[i]]
	# 	gi = [goals[i].goal_instances[0]]
	# 	idx = goals[i].goal_instances[0].id - goal_instances.first.id
	# 	puts "idx = " + idx.to_s
	# 	goal_instances_flag[idx] = true
	# end

	# n = rand(n_gi/n_u)
	# for i in 1..n
	# 	while goal_instances_flag[j]  && j < n_gi do
	# 		j += 1
	# 	end 
		
	# 	if j < n_gi
	# 		gi << goal_instances[j]
	# 		goal_instances_flag[j] = false
	# 	end
	# end
	# puts "* j = " + j.to_s

	if i < n_g
		g << goals[i]
		gi << goals[i].goal_instances[0]
	end

	n = rand(n_gi/n_u)
	puts "gi: n = " + n.to_s

	for ii in 1..n
		puts "<> goal_instances_flag[j] = " + goal_instances_flag[j].to_s 
		puts "<> b: j = " + j.to_s
		while (goal_instances_flag[j]) && (j < n_gi) do
			j += 1
		end 

		puts "<> j = " + j.to_s
		
		if j < n_gi
			gi << goal_instances[j]
			goal_instances_flag[j] = true
		end
	end
	puts "* j = " + j.to_s

	usr = JSON.parse(u.to_json)

	puts "g = " + g.to_json
	puts 
	puts "gi = " + gi.to_json
	puts

	User.create(
		{fb_id: usr['id'], first_name: usr['first_name'], last_name: usr['last_name'], 
				goals:g, goal_instances: gi
		}
	)

	i += 1
}


# goal_instances=GoalInstance.create([
# 	{start_date: Date.today, end_date: Date.tomorrow, cheer_ons:4, is_complete:false},
# 	{start_date: Date.today, end_date: Date.tomorrow, cheer_ons:2, is_complete:false},
# 	{start_date: Date.yesterday, end_date: Date.tomorrow, cheer_ons:7, is_complete:false}
# ])


# @api = Koala::Facebook::API.new("CAACEdEose0cBAJExbI4M41ZCG8bnpz1jIUMTTe43O8ajQiAJgSyAj9Ohqqo9xeo9uNCIOP6JmCBkxWFCCivBDK1iLOHUVZBxNBc5sI8bZCdxbK4aFBH12FXRoQBtfsQoUxffx6TTKFZAB1ObeNilxN9TG1yrwVl4E0OWV25L9StHfBRbEZCpQMfp3RZBJblW0KT2sZAA2aaUAZDZD")

# goal_data = @api.get_object("/350133225119092/")
# goal_data = @api.get_connections(goal_data["id"],"posts")
# goals = []

# goals_data_json = []

# begin
# goal_data.each {|goal| 
	
#    if (goal["message"] and !(goal["message"].include? "beach!" or goal["message"].include? "Beer!" or goal["message"].include? "500"))
#      goal = Goal.create({title:goal["message"],description: "Description: "+goal["message"], picture:goal["picture"],goal_instances:[goal_instances[0]]})
#      goals.push(goal)
	 
#    end
# }
# goal_data=goal_data.next_page
# end while goal_data

# goal_data = @api.get_object("/1000thingsincroatia/")
# goal_data = @api.get_connections(goal_data["id"],"posts")
# begin
# goal_data.each {|goal| 
	
#    if (goal["message"] and goal["picture"] and !(goal["message"].include? "beach!" or goal["message"].include? "Beer!"))
#      puts goal["message"]+ " " +goal["picture"]
#      goal = Goal.create({title:goal["message"].sub!(/^#[0-9]*\s/,""),description: "Description: "+goal["message"], picture:goal["picture"],goal_instances:[goal_instances[0]]})
#      goals.push(goal)
     
#    end
# }
# goal_data=goal_data.next_page
# end while goal_data


# goal_data = @api.get_object("/100ThingsToDoInLife/")
# goal_data = @api.get_connections(goal_data["id"],"milestones")
# begin
# goal_data.each {|goal| 
	
#    if (goal["title"] and !(goal["title"].include? "father" or goal["title"].include? "24" or goal["title"].include? "love" or goal["title"].include? "beach!" or goal["title"].include? "Beer!") and goal["description"])
#      puts goal["message"]+ " " +goal["picture"]
#      goal = Goal.create({title:goal["title"].sub(/\([A-Z]*\)/,""),description: goal["description"], goal_instances:[goal_instances[0]]})
#      goals.push(goal)
#    end
# }
# goals[0].goal_instances.push(goal_instances[0])
# goals[1].goal_instances.push(goal_instances[1])
# goals[2].goal_instances.push(goal_instances[2])

# goal_data=goal_data.next_page
# end while goal_data
# goals=Goal.create([
	# {title: 'Surf', description: 'Learn to surf 3 differnt styles', 
			# goal_instances: [goal_instances[0],goal_instances[1],goal_instances[2]]},
	# {title: 'Cook', description: 'Learn to cook pasta',goal_instances: []},
	# {title: 'Run Faster', description: 'Practise for 5km marathon',goal_instances: [], picture:"http://www.running4thereason.com/wp-content/uploads/2013/09/cropped-IMG_4620.jpg"}
# ])


# users = User.create([
# 	{fb_id: '657850580', first_name: 'Nazli', last_name: 'Dereli', 
# 				goals: goals, goal_instances: [goal_instances[0],goal_instances[1]]},
# 	{fb_id: '100001639762906', first_name: 'Dibyendu', last_name: 'Nath', 
# 				goals: [], goal_instances: [goal_instances[1],goal_instances[2]]}, 
# 	{fb_id: '1307365962', first_name: 'Arvind', last_name: 'C R', 
# 				goals: [goals[1]], goal_instances: [goal_instances[2]]},
# 	{fb_id: '530115125', first_name: 'Divya', last_name: 'Sambasivan', 
# 				goals: [goals[0]], goal_instances: [goal_instances[0],goal_instances[1],goal_instances[2]]}
# ])

