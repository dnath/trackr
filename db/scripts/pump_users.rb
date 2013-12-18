require "Koala"
require "json"

api = Koala::Facebook::API.new("CAACEdEose0cBAKw9nFWe11ZAV9ZCsuOAfhk8m7YpwZCxZAGub0idkPh5HyVxQnGKI3tIP19eEwIJX32zGnes08uzyjMZCBX3T0jNwNAlBg4r9CBoLaFivApHhhmfMZA66ojj8uj9qBihsrjAbtanaCHI4otgWLLaKh78VCchJdkW2hW6bKNFJUMIg78QIowzvWyEJDCqFcVwZDZD")

fb_ids = []

for i in 502040402..502045402 
	fb_ids << i
end

# puts "fb_ids = " + fb_ids.to_s

data = api.get_objects(fb_ids, :fields => "id,first_name,last_name").values

puts "n = " + data.length.to_s

# puts "data = "

file = open('test6.json', 'w')
file.write(JSON.pretty_generate(data))
file.close




# 502013402
# 502022634
# 503810355
# 514061233
# 517458011
# 517984729
# 518489154
# 519497752
# 522157150
# 523399627
# 529310446
# 530115125
# 536058247
# 539671731
# 541355118
# 547782792
# 550181493
# 550327152
# 556936879 
