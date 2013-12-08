class GoalsController < ApplicationController
  before_filter :authorize, only: [:update, :destroy]
  cache_sweeper :goals_sweeper, :only => [:create, :update, :destroy]
  caches_action :index, :expires_in => 30.minutes,  :cache_path => Proc.new { |c| c.params } # index_cache_path.to_proc
  
  # caches_action :index, : cache_path: :updated_request_params_to_include_format_for_cache_key.to_proc

  def index_cache_path
    return 'tmp/cache/goals' + params[:search].to_s + params[:page].to_s
  end

  # def updated_request_params_to_include_format_for_cache_key
  #   params.merge({ format: request.format.symbol || 'html' })
  # end
  
  # GET /goals
  # GET /goals.json
  def index
    #@goals = Goal.all
    if(params[:search])
      search = params[:search]
      #cache ["goals",@goals] do
      @goals = Goal.paginate(:page => params[:page], 
                              :per_page => 12,
                              :conditions => ['title like ?', 
                              "%#{search}%"], 
                              :order => 'title')
      #end
    else
      @goals = Goal.paginate(:page => params[:page], 
                              :per_page => 12, 
                              :order => 'title')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goals }
    end
  end

  def search

  end
  
  # GET /goals/1
  # GET /goals/1.json
  def show
    @goal = Goal.find(params[:id])
    @api = Koala::Facebook::API.new(session[:access_token])
    @is_current_user_joined = false

    _users = User.where('id in (?)',@goal.goal_instances.pluck(:user_id)).pluck(:fb_id)
    _current_follower_ids = _users
    if _current_follower_ids.length > 0
      @current_followers= @api.get_objects(_current_follower_ids, :fields=>"first_name,last_name,picture")
      if @current_followers.length > 0 then
        @current_followers = @current_followers.values
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal }
    end
  end

  # GET /goals/new
  # GET /goals/new.json
  def new
    @goal = Goal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal }
    end
  end

  # GET /goals/1/edit
  def edit
    @goal = Goal.find(params[:id])
  end

  # POST /goals.json
  def create
    # expire_action :action => :index
    # cache_key = "views/tmp/cache/goals"
    # Rails.cache.delete(cache_key)

    @goal = Goal.new(params[:goal])
    current_user = User.find(session[:current_user])
    current_user.goals.push(@goal)
    respond_to do |format|
      if @goal.save
        format.html { redirect_to @goal, notice: 'Goal was successfully created.' }
        format.json { render json: @goal, status: :created, location: @goal }
      else
        format.html { render action: "new" }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /goals/1
  # PUT /goals/1.json
  def update
    # expire_action :action => :index
    # cache_key = "views/tmp/cache/goals"
    # Rails.cache.delete(cache_key)

    @goal = Goal.find(params[:id])

    respond_to do |format|
      if @goal.update_attributes(params[:goal])
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    # expire_action :action => :index
    # cache_key = "views/tmp/cache/goals"
    # Rails.cache.delete(cache_key)

    @goal = Goal.find(params[:id])
      respond_to do |format|
        if !@goal.destroy
          format.html {redirect_to @goal , notice: "You may not edit or delete this goal. There are users currently following it."}
          format.json {head :no_content}
        else
          format.html { redirect_to goals_url }
          format.json { head :no_content }
        end 
      end
    
  end
  
  private
    def authorize
      @goal = Goal.find(params[:id])
        #unless @goal.user.id == session[:current_user]
         # redirect_to @goal , notice: 'You are not authorized to execute this action'
      #end
    end
end
