require 'rubygems'
require 'nokogiri'  
require 'open-uri'
require 'json'
source_url = "http://www.bucketlist.net/lists/all_lists/?page="
description = "I have been wanting to do this all my life but have not been able to get myself to do it."\
                "I really wish you guys help me get it this time. Yeah! Let's do this together. I want to "

#read the existing goals
file = open('goals.json')
goals_data = JSON.parse(file.read)["goals"]

puts "number of existing goals= "+ goals_data.length.to_s
begin
  for page_number in (1..650)
    puts source_url + page_number.to_s
    page = Nokogiri::HTML(open(source_url + page_number.to_s))  
    if page 
      for goal_number in (1..20)
        puts "reading goal "+(page_number*goal_number).to_s
        goal={}
        goal_tag = page.css('div#lists>div')[goal_number]
        if goal_tag
          goal[:picture] = goal_tag.css('div.thumb_url>a')[0]?goal_tag.css('div.thumb_url>a')[0]["href"]:nil
          goal[:title] = goal_tag.css('div.action>h4>a').text
          goal[:description] = goal_tag.css('div.action>div.body>p').text != ""?
                                          goal_tag.css('div.action>div.body>p').text : description + goal[:title]
          if (goal[:picture]!= nil)
            goals_data << goal
          end
        end
      end
    end
  end
rescue => e
  
end
goals = {}
goals["goals"] = goals_data
puts "updated number of goals = "+ goals_data.length.to_s

file = open('goals1.json', 'w')
file.write(JSON.pretty_generate(goals))