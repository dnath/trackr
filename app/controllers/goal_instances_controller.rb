class GoalInstancesController < ApplicationController
  cache_sweeper :goal_instances_sweeper, :only => [:create, :update, :destroy]
  caches_action :index, :expires_in => 30.minutes,  :cache_path => Proc.new { |c| c.params } # index_cache_path.to_proc

  # GET /goal_instances
  # GET /goal_instances.json
  def index
    puts 'params[:user_id] = ' + params[:user_id].inspect
    if params[:user_id] == nil
      current_user = User.find(session[:current_user])
    else
      current_user = User.find(params[:user_id])
    end
    
    @goal_instances = current_user.goal_instances
    @goal_instances = @goal_instances.paginate(:page => params[:page], :per_page => 5)
    @milestones = Milestone.find_by_goal_instance_id(params[:id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {:goal_instances => @goal_instances, :milestones => @milestones}}
    end
  end

  # GET /goal_instances/1
  # GET /goal_instances/1.json
  def show

    @goal_instance = GoalInstance.find(params[:id])
    @is_current_user_joined = false
    goal_ins = GoalInstance.where('user_id = :uid and goal_id = :gid', 
                  {uid: session[:current_user], gid: @goal_instance.goal.id})
    puts 'goal_ins = ' + goal_ins.to_s
    puts 'goal_ins.length = ' + goal_ins.length.to_s

    if goal_ins.length > 0
      @is_current_user_joined = true;
    end

    @milestones = @goal_instance.milestones

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: {:goal_instances => @goal_instances, :milestones => @milestones}}
   end
end

def update_preview
  puts "-> hey!!!"
end

#def completed
# @goal_instan = GoalInstance.find(params[:goal_instance_id])
# @milesto = @goal_instan.milestones.find([params[:id])
#  respond_to do |format|
#  format.js { render :nothing => true }
#  format.html redirect_to(@goal_instan)
#end
 

  # GET /goal_instances/new
  # GET /goal_instances/new.json
  def new
    @goal_instance = GoalInstance.new
    3.times{ @goal_instance.milestones.build }
    puts params[:goal_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal_instance }
    end
  end

  # GET /goal_instances/1/edit
  def edit
    @goal_instance = GoalInstance.find(params[:id])
  end
   

  # POST /goal_instances
  # POST /goal_instances.json
  def create
    puts params.to_s()
    @goal_instance = GoalInstance.new(params[:goal_instance])
    current_user = User.find(session[:current_user])
    current_user.goal_instances.push(@goal_instance)
    puts params[:goal_instance][:goal_id]
    current_goal = Goal.find(params[:goal_instance][:goal_id]) 
    current_goal.goal_instances.push(@goal_instance)
    respond_to do |format|
      if @goal_instance.save
        format.html { redirect_to @goal_instance, notice: 'Goal instance was successfully created.' }
        format.json { render json: @goal_instance, status: :created, location: @goal_instance }
      else
        format.html { render action: "new" }
        format.json { render json: @goal_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /goal_instances/1
  # PUT /goal_instances/1.json
  def update
    @goal_instance = GoalInstance.find(params[:id])

    respond_to do |format|
      if @goal_instance.update_attributes(params[:goal_instance])
        format.html { redirect_to @goal_instance, notice: 'Goal instance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @goal_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goal_instances/1
  # DELETE /goal_instances/1.json
  def destroy
    @goal_instance = GoalInstance.find(params[:id])
    @goal_instance.destroy

    respond_to do |format|
      format.html { redirect_to goal_instances_url(:user_id => User.find(session[:current_user]).id) }
      format.json { head :no_content }
    end
  end

  # PUT /goal_instances/1/cheeron
  def cheeron
    puts 'Cheeron ajax'
    @goal_instance = GoalInstance.find(params[:id])
    @goal_instance.cheer_ons = @goal_instance.cheer_ons + 1
    @goal_instance.update_attributes(params[:goal_instance])

    respond_to do |format|
      format.html {redirect_to @goal_instance}
    end
  end

  def check
    puts 'cheeeeeeck milestone'
    @goal_instance = GoalInstance.find(params[:id])
    Milestone.update(params[:milestone_id],:is_complete => '1')
    milestone = @goal_instance.milestones.find(params[:milestone_id])

    if params[:complete] == (@goal_instance.end_date-@goal_instance.start_date).to_f
      @goal_instance.is_complete = '1'
      @goal_instance.update_attributes(params[:goal_instance])
    end
     respond_to do |format|
      format.html {redirect_to goal_instance_path(:complete => params[:complete].to_f + ((@goal_instance.end_date - @goal_instance.start_date) * (milestone.duration.to_f/params[:sum].to_f)))}
    end
  end
end
