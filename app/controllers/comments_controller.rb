class CommentsController < ApplicationController
before_filter :get_milestone

  def get_milestone
    @Milestone = Milestone.find(params[:post_id])
  end

  def index
    @comments = @Milestone.comments.all # or sorted by date, or paginated, etc.
  end
  
   def create
  @post = @post.find params[:post_id]
  @comment = @post.comments.new params[:comment]
  if @comment.save
    redirect_to @post
  end
  end
end
  
