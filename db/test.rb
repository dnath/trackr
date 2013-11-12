require "Koala"
require "json"

@api = Koala::Facebook::API.new("CAACEdEose0cBANOIDvW0Jtf66T4HmkOiaCMqR4hTkHZAawwmtXZCYqDYyijAR97LXAL0QM6kt3yZBquqvXYG8OZB7iXltHH2DwZCHY5k0aGhB4LZAPKvTCE56IruNhbMlnnU8Q3UQStAMyS6Id53Ay0C0aJkXChL3D5LAnvZA8RZCZCZBneQQJKSFGPqT0KB604ZBgBofZC8T0UjQAZDZD")

goal_data = @api.get_object("/350133225119092/")
goal_data = @api.get_connections(goal_data["id"],"posts")

goals_data_json = []

begin
goal_data.each {|goal| 
	
   if (goal["message"] and !(goal["message"].include? "beach!" or goal["message"].include? "Beer!" or goal["message"].include? "500"))
     # puts goal["message"]+ " " +goal["picture"]
     goal_json = {:title => goal["message"], :description => goal["message"], :picture => goal["picture"]}
     # puts JSON.pretty_generate(goal_json)
     goals_data_json << goal_json;
     # puts goals_data_json
   end
}
goal_data=goal_data.next_page
end while goal_data

goal_data = @api.get_object("/1000thingsincroatia/")
goal_data = @api.get_connections(goal_data["id"],"posts")
begin
goal_data.each {|goal| 
	
   if (goal["message"] and goal["picture"] and !(goal["message"].include? "beach!" or goal["message"].include? "Beer!"))
     # puts goal["message"]+ " " +goal["picture"]
     goal_json = {:title => goal["message"].sub!(/^#[0-9]*\s/,""), :description => goal["message"], :picture => goal["picture"]}
     # puts JSON.pretty_generate(goal_json)
     goals_data_json << goal_json;
     # puts goals_data_json
   end
}
goal_data=goal_data.next_page
end while goal_data


goal_data = @api.get_object("/100ThingsToDoInLife/")
goal_data = @api.get_connections(goal_data["id"],"milestones")
begin
goal_data.each {|goal| 
	
   if (goal["title"] and !(goal["title"].include? "father" or goal["title"].include? "24" or goal["title"].include? "love" or goal["title"].include? "beach!" or goal["title"].include? "Beer!") and goal["description"])
     # puts goal["message"]+ " " +goal["picture"]
     goal_json = {:title => goal["title"].sub(/\([A-Z]*\)/,""), :description => goal["message"], :picture => goal["picture"]}
     # puts JSON.pretty_generate(goal_json)
     goals_data_json << goal_json;
     # puts goals_data_jsonputs goal["message"]+ " " +goal["picture"]
   end
}
goal_data=goal_data.next_page
end while goal_data

# puts JSON.pretty_generate(goals_data_json)
data = { :goals => goals_data_json}
puts JSON.pretty_generate(data)

file = open('goals.json', 'w')
file.write(JSON.pretty_generate(data))
file.close
