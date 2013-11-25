class LoginController < ApplicationController
  def index
    current_user = User.find(session[:current_user]) if session[:current_user]

    if current_user
      respond_to do |format|
        puts "id = " + current_user.id.to_s
        format.html{ redirect_to :controller => "goal_instances", :action => "index", :user_id => current_user.id }
      end 
    end

    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/login/callback')
    
    puts("ENVIRONMENT")
    puts SITE_URL
    puts APP_SECRET
    puts APP_ID
    
    @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"read_stream")
    
    puts session.to_s + "<<< session"
    respond_to do |format|
      format.html{}
    end
  end

  def destroy
    puts 'destroy'
    session[:current_user] = nil
    session[:current_user_first_name] = nil
    session[:current_user_last_name] = nil
    
    session[:oauth] = nil
    session[:access_token] = nil
    
    redirect_to root_url, :notice => "You logged out successfully !"
  end

  def callback
     #handle error callback
    @error_message= nil
    if params[:error_code].eql? "200"
      @error_message = "You have denied the permissions to access the Trac.kr App." + 
                          " Please allow it, in order to continue"
    end
    if params[:code]
      session[:access_token] = session[:oauth].get_access_token(params[:code])
      puts session[:access_token]
      @api = Koala::Facebook::API.new(session[:access_token])
      begin
        user_data = @api.get_object("/me/?fields=first_name,last_name,username,id,picture") 
          # "fields"=>["first_name","last_name","username", "id"])
        existing_user = User.find_by_fb_id(user_data["id"])
        
        if existing_user
          session[:current_user] = existing_user.id
          session[:current_user_first_name] = existing_user.first_name
          session[:current_user_last_name] = existing_user.last_name

        else not existing_user
          new_user = User.create(
            first_name: user_data["first_name"],
            last_name: user_data["last_name"],
            fb_id: user_data["id"]
          );

          session[:current_user] = new_user.id
          session[:current_user_first_name] = new_user.first_name
          session[:current_user_last_name] = new_user.last_name
        end
        session[:current_user_picture] = user_data["picture"]["data"]["url"]
        puts "user picture = " + session[:current_user_picture]
      rescue Exception=>ex
        puts "EXCEPTION EXCEPTION"
        puts ex.message
      end
    end
    respond_to do |format|
        format.html {
                   redirect_to goal_instances_url(:user_id => User.find(session[:current_user]).id)
         }   
        format.json { }                   
    end
  end

  def perf_login
      session[:access_token] = params[:fb_token]
      @api = Koala::Facebook::API.new(session[:access_token])
      begin
        user_data = @api.get_object("/me/?fields=first_name,last_name,username,id,picture") 
        existing_user = User.find_by_fb_id(user_data["id"])
        
        if existing_user
          session[:current_user] = existing_user.id
          session[:current_user_first_name] = existing_user.first_name
          session[:current_user_last_name] = existing_user.last_name

        else not existing_user
          new_user = User.create(
            first_name: user_data["first_name"],
            last_name: user_data["last_name"],
            fb_id: user_data["id"]
          );

          session[:current_user] = new_user.id
          session[:current_user_first_name] = new_user.first_name
          session[:current_user_last_name] = new_user.last_name
        end

        session[:current_user_picture] = user_data["picture"]["data"]["url"]

        puts "user picture = " + session[:current_user_picture]
        redirect_to goal_instances_url(:user_id => User.find(session[:current_user]).id)
      rescue Exception=>ex
        puts "EXCEPTION EXCEPTION"
        puts ex.message
      end
    end
    
end
