class MilestonesController < ApplicationController
  # GET /milestones
  # GET /milestones.json

#def add_to_my_books
 #  @milestones = Milestone.all
  #  @miles = Milestone.where(:id => 1)

   # respond_to do 
    #    format.js {render alert("book added to your books")}
  #  end        
#end


  def index
    @milestones = Milestone.all
    @miles = Milestone.where(:id => 1)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @milestones }
    end
   
  end
  def set_my_session_var
    session[:somekey]='somevalue'
  end
  # GET /milestones/1
  # GET /milestones/1.json

  def show
    @milestone = Milestone.find(params[:id])
    @comment = @milestone.comments.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @milestone }
    end
  end

  # GET /milestones/new
  # GET /milestones/new.json

  def new
    @milestone = Milestone.new
    @comment = Comment.new
    @comment.comment = 'Some comment'
    @milestone.comments << @comment
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @milestone }
    end
  end

  # GET /milestones/1/edit

  def edit
    @milestone = Milestone.find(params[:id])
  end

  # POST /milestones
  # POST /milestones.json

  def create
    @milestone = Milestone.new(params[:goal_id])

    respond_to do |format|
      if @milestone.save
        format.html { redirect_to @milestone, notice: 'Milestone was successfully created.' }
        format.json { render json: @milestone, status: :created, location: @milestone }
      else
        format.html { render action: "new" }
        format.json { render json: @milestone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /milestones/1
  # PUT /milestones/1.json
  def update
    @milestone = Milestone.find(params[:id])

    respond_to do |format|
      if @milestone.update_attributes(params[:milestone])
        format.html { redirect_to @milestone, notice: 'Milestone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @milestone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /milestones/1
  # DELETE /milestones/1.json
  def destroy
    @milestone = Milestone.find(params[:id])
    @milestone.destroy

    respond_to do |format|
      format.html { redirect_to milestones_url }
      format.json { head :no_content }
    end
  end
end
