class FriendsController < ApplicationController
  helper_method :user_image_url

  def index
  	current_user = User.find(session[:current_user])
  	api = Koala::Facebook::API.new(session[:access_token])
  	current_user_friends = api.get_object("/" + current_user.fb_id + "/?fields=friends.fields(id,name,picture)")
  	
    current_user_friends_in_trackr = []
    current_user_friend_ids = []
   
    current_user_friends['friends']['data'].each { |friend|
      # puts friend['id'].to_s
      current_user_friend_ids.push(friend['id']);
    }
    
    current_user_friends_in_trackr = User.find_all_by_fb_id(current_user_friend_ids)
    @friends = current_user_friends_in_trackr

    # puts "*************************************"
    # @current_user_friends_in_trackr.each { |friend|
    #  puts friend.first_name.to_s
    # }
  	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: current_user_friends_in_trackr }
      format.xml { render xml: current_user_friends['friends']['data'] }
    end
  end

  def user_image_url(user_id)
    puts user_id
    api = Koala::Facebook::API.new(session[:access_token])
    # puts "/" + user_id.to_s + "/?fields=picture"
    user_image_url = api.get_object("/" + User.find(user_id)['fb_id'].to_s + "/?fields=picture")
    # puts "*****************************" + user_image_url['picture']['data']['url']
    return user_image_url['picture']['data']['url']
  end  
end
