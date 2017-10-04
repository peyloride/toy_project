class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_toy

  def new
    @comment = Comment.new
  end

  def like
    @comment = Comment.find(params[:comment_id])
    current_user.likes @comment
    redirect_back(fallback_location: root_path)
  end

  def create
    @comment = @toy.comments.new comment_params
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
         format.js
      end
    else
      redirect_back(fallback_location: root_path, notice: "Your comment wasn't posted!")
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_toy
    @toy = Toy.find_by_id(params[:toy_id])
  end
end
