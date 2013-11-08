class LoginController < ApplicationController
  def index
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

  def callback
     #handle error callback
    @error_message= nil
    if params[:error_code].eql? "200"
      @error_message = "You have denied the permissions for the App. Please allow it, in order to continue"
    end
    if params[:code]
      session[:access_token] = session[:oauth].get_access_token(params[:code])
      puts session[:access_token]
      @api = Koala::Facebook::API.new(session[:access_token])
      begin
        user_data = @api.get_object("/me/", "fields"=>["first_name","last_name","username", "id"])
        existing_user = User.find_by_fb_id(user_data["id"])
        if existing_user
          session[:current_user] = existing_user.id
        else not existing_user
          new_user = User.create(
            first_name: user_data["first_name"],
            last_name: user_data["last_name"],
            fb_id: user_data["id"]
          );
          session[:current_user] = new_user.id
        end
        
      rescue Exception=>ex
        puts "EXCEPTION EXCEPTION"
        puts ex.message
      end
    end
    respond_to do |format|
        format.html {
            if not @error_message 
                   redirect_to goals_url
            end 
         }   
        format.json { }                   
    end
  end
end
