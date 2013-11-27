# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Goal.delete_all
User.delete_all
GoalInstance.delete_all
Milestone.delete_all
 n_gi = 180 # 10000
# n_g  = 18 # 110
# n_u  = 33 # 1300
milestones= []
# 
#Arvind
oi = 3
nod = 4
tit = 'milestone'
desc = 'trav'
uservar='user_'
#milstones.push(goal_instance);
 #       milstones_flag << false


milestone = []

#####################################################
goal_instances = []
goal_instances_flag = []

# #for i in 1..n_gi
#         st = Date.today - rand(30)
#         et = st + rand(45)
#         complete = false
#         if et > Date.today
#                 complete = true
#         end
#        milestone = Milestone.create(
#                 [{ goal_instance: i, no_of_days: nod , title: tit+'1', description: desc }]

#         )
# milestone = Milestone.create(
#                [{ goal_instance: i, no_of_days: nod , title: tit+'2', description: desc }]

#         )
# milestone = Milestone.create(
#                 [{ goal_instance: i, no_of_days: nod , title: tit+'3', description: desc }]

#         )


# end

# #####################################################
# goal_instances = []
# goal_instances_flag = []

#Divya - code starts
#create users
number_users = 0
users = []
file = open('db/test_users.json', 'r')
users_data = JSON.parse(file.read)
file.close

users_data['users'].each { |user_data|
  puts "."
  user_json = JSON.parse(user_data.to_json)
  user = User.create({fb_id: user_json['id'], first_name: user_json['first_name'], last_name: user_json['last_name']
                })
  number_users +=1
  users.push(user)
}

#create goals

file = open('db/goals.json')
goals_data = JSON.parse(file.read)
file.close
goals = []
goals_data['goals'].each { |goal_data|
  goal_json = JSON.parse(goal_data.to_json)
  goal = Goal.create(
          { title:goal_json["title"], description: goal_json["description"], picture: goal_json["picture"] }
  )
  User.find(users[rand(users.length)].id).goals.push(goal) #add a random User as the creater of the goal
  goals.push(goal)              
}

#create goal instances
number_goal_instances = 10000
goal_instances = []
for i in 0..number_goal_instances-1
   puts "goal instance "+ i.to_s
   st = Date.today - rand(30)
   et = st + rand(45)
   complete = false
    if et < Date.today
       complete = true
    end
    goal_instance = GoalInstance.create(
                { start_date: st, end_date: et, cheer_ons:rand(users.length/2), is_complete: complete},
        )
    Goal.find(goals[rand(goals.length)].id).goal_instances.push(goal_instance)
    User.find(users[rand(users.length)].id).goal_instances.push(goal_instance) #make this instance of a random user
        milestone = Milestone.create( [{ description: 'This is description of milestone1', duration: '10 days' , is_complete: false }]
         )

goal_instance.milestones.push(milestone)
 milestone = Milestone.create(
               { description: 'This is description of milestone2', duration: '10 days' , is_complete: false }

        )
goal_instance.milestones.push(milestone)
 milestone = Milestone.create(
{ description: 'This is description of milestone3', duration: '10 days' , is_complete: false}

         )
goal_instance.milestones.push(milestone)
end 
