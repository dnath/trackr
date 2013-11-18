class FriendsController < ApplicationController
  helper_method :user_image_url

  def index
  	current_user = User.find(session[:current_user])
  	api = Koala::Facebook::API.new(session[:access_token])
  	current_user_friends = api.get_object("/" + current_user.fb_id + "/?fields=friends.fields(id)")
  	
    current_user_friends_in_trackr = []
    current_user_friend_ids = []
   
    current_user_friends['friends']['data'].each { |friend|
      # puts 'friend = ' + friend.to_s
      current_user_friend_ids << friend['id']
    }
    
    current_user_friends_in_trackr = User.find_all_by_fb_id(current_user_friend_ids)

    current_user_friends_fb_ids = []
    current_user_friends_in_trackr.each { |f|
      current_user_friends_fb_ids << f['fb_id']
    }

    # puts "current_user_friends_fb_ids = " + current_user_friends_fb_ids.to_s

    @current_trackr_friends = api.get_objects(current_user_friends_fb_ids, :fields=>"first_name,last_name,picture").values
    
    # @current_user_friends_in_trackr.each { |friend|
    #  puts friend.first_name.to_s
    # }
  	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: current_user_friends_in_trackr }
      format.xml { render xml: current_user_friends['friends']['data'] }
    end
  end
end
