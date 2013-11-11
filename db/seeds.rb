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

goal_instances=GoalInstance.create([
	{start_date: Date.today, end_date: Date.tomorrow, cheer_ons:4, is_complete:false},
	{start_date: Date.today, end_date: Date.tomorrow, cheer_ons:2, is_complete:false},
	{start_date: Date.yesterday, end_date: Date.tomorrow, cheer_ons:7, is_complete:false}
])


@api = Koala::Facebook::API.new("CAACEdEose0cBAHaqe4y0yefZBFYGshm1tK3G1uXIRiejzXbYZA05ZBmoWm3ss3pHj95odu3HQAgZCF4CmjYmJzWmWIae6kfNatR5YgbtCslNHf2sppMGoNn7JeYEp6H3RV1KqUD4OrymyzCzYb6vp73oz2vEzYZAL9BldZAQvd4hp8vYJfwlVdr2GZA1R5AGbrwu2BFVSErGAZDZD")

goal_data = @api.get_object("/350133225119092/")
goal_data = @api.get_connections(goal_data["id"],"posts")
goals = []

begin
goal_data.each {|goal| 
   if (goal["message"] and !(goal["message"].include? "beach!" or goal["message"].include? "Beer!" or goal["message"].include? "500"))
     goal = Goal.create({title:goal["message"],description: "Description: "+goal["message"], picture:goal["picture"],goal_instances:[goal_instances[0]]})
     goals.push(goal)
   end
}
goal_data=goal_data.next_page
end while goal_data

goal_data = @api.get_object("/1000thingsincroatia/")
goal_data = @api.get_connections(goal_data["id"],"posts")
begin
goal_data.each {|goal| 
   if (goal["message"] and goal["picture"] and !(goal["message"].include? "beach!" or goal["message"].include? "Beer!"))
     goal = Goal.create({title:goal["message"].sub!(/^#[0-9]*\s/,""),description: "Description: "+goal["message"], picture:goal["picture"],goal_instances:[goal_instances[0]]})
     goals.push(goal)
   end
}
goal_data=goal_data.next_page
end while goal_data


goal_data = @api.get_object("/100ThingsToDoInLife/")
goal_data = @api.get_connections(goal_data["id"],"milestones")
begin
goal_data.each {|goal| 
   if (goal["title"] and !(goal["title"].include? "father" or goal["title"].include? "24" or goal["title"].include? "love" or goal["title"].include? "beach!" or goal["title"].include? "Beer!") and goal["description"])
     goal = Goal.create({title:goal["title"].sub(/\([A-Z]*\)/,""),description: goal["description"], goal_instances:[goal_instances[0]]})
     goals.push(goal)
   end
}
goals[0].goal_instances.push(goal_instances[0])
goals[1].goal_instances.push(goal_instances[1])
goals[2].goal_instances.push(goal_instances[2])

goal_data=goal_data.next_page
end while goal_data
# goals=Goal.create([
	# {title: 'Surf', description: 'Learn to surf 3 differnt styles', 
			# goal_instances: [goal_instances[0],goal_instances[1],goal_instances[2]]},
	# {title: 'Cook', description: 'Learn to cook pasta',goal_instances: []},
	# {title: 'Run Faster', description: 'Practise for 5km marathon',goal_instances: [], picture:"http://www.running4thereason.com/wp-content/uploads/2013/09/cropped-IMG_4620.jpg"}
# ])


users = User.create([
	{fb_id: '657850580', first_name: 'Nazli', last_name: 'Dereli', 
				goals: goals, goal_instances: [goal_instances[0],goal_instances[1]]},
	{fb_id: '100001639762906', first_name: 'Dibyendu', last_name: 'Nath', 
				goals: [], goal_instances: [goal_instances[1],goal_instances[2]]}, 
	{fb_id: '1307365962', first_name: 'Arvind', last_name: 'C R', 
				goals: [goals[1]], goal_instances: [goal_instances[2]]},
	{fb_id: '530115125', first_name: 'Divya', last_name: 'Sambasivan', 
				goals: [goals[0]], goal_instances: [goal_instances[0],goal_instances[1],goal_instances[2]]}
])

