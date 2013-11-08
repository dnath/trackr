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

goals=Goal.create([
	{title: 'Surfing', description: 'Learn to surf 3 different styles', 
			goal_instances: [goal_instances[0],goal_instances[1],goal_instances[2]]},
	{title: 'Cooking Pasta', description: 'Learn to cook pasta.',goal_instances: []},
	{title: 'Run Faster', description: 'Practise for 5km marathon',goal_instances: []}
])

users = User.create([
	{fb_id: '657850580', first_name: 'Nazli', last_name: 'Dereli', 
				goals: [goals[0]], goal_instances: [goal_instances[0]]},
	{fb_id: '100001639762906', first_name: 'Dibyendu', last_name: 'Nath', 
				goals: [], goal_instances: [goal_instances[1]]}, 
	{fb_id: '1307365962', first_name: 'Arvind', last_name: 'C R', 
				goals: [goals[1]], goal_instances: [goal_instances[2]]},
	{fb_id: '530115125', first_name: 'Divya', last_name: 'Sambasivan', 
				goals: [goals[2]]}
])

