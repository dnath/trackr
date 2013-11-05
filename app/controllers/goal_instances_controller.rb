class GoalInstancesController < ApplicationController
  # GET /goal_instances
  # GET /goal_instances.json
  def index
    current_user = User.find(params[:user_id])
    @goal_instances = current_user.goal_instances

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goal_instances }
    end
  end

  # GET /goal_instances/1
  # GET /goal_instances/1.json
  def show
    @goal_instance = GoalInstance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal_instance }
    end
  end

  # GET /goal_instances/new
  # GET /goal_instances/new.json
  def new
    @goal_instance = GoalInstance.new
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
    @goal_instance = GoalInstance.new(params[:goal_instance])
    current_user = User.find(session[:current_user])
    current_user.goal_instances.push(@goal_instance)
    current_goal = Goal.find(params[:goal_id]) 
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
      format.html { redirect_to goal_instances_url }
      format.json { head :no_content }
    end
  end
end