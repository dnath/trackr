class FriendsController < ApplicationController
  # caches_action :index, :expires_in => 30.minutes

  def index
  	@current_user = User.find(session[:current_user])
  	
    @api = Koala::Facebook::API.new(session[:access_token])
  	
    @result = @api.get_object("/" + current_user.fb_id + "/?fields=friends.fields(id)")
 
    @current_user_friend_ids = []
   
    @result['friends']['data'].each { |friend|
      # puts 'friend = ' + friend.to_s
      @current_user_friend_ids << friend['id']
    }
    
    # cache 'trackr_users' do
      @trackr_users = User.find_all_by_fb_id(@current_user_friend_ids)
    # end

    @fb_ids = []
    @trackr_users.each { |f|
      @fb_ids << f['fb_id']
    }

    @result = @api.get_objects(@fb_ids, :fields=>"id,first_name,last_name,picture").values
    
    # puts "**** result = " + @result.to_s

    @friends = []
    @result.each { |r|
      # puts "r = " + r.to_s
      fb_id_1 = nil
      @trackr_users.each { |u|
        if u.fb_id == r["id"]
          fb_id_1 = u.id
        end
      }
      @friends << { 
        :fb_id => r["id"], 
        :first_name => r["first_name"], 
        :last_name => r["last_name"], 
        :picture_url => r["picture"]["data"]["url"],
        :id => fb_id_1
      }
    }

    #puts @friends.to_s
  	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friends }
    end
  end
end
