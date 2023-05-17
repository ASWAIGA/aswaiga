class CommentsController < ApplicationController
  def create
    @issue = Issue.find(params[:issue_id])
    @comment = @issue.comments.create(comment_params)
    redirect_to @issue
  end

  def index
    @comments = Comment.all
    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def show
    @comment = @issue.comments.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @comment }
    end
  end

  def destroy
    @issue = Issue.find(params[:issue_id])
    @comment = @issue.comments.find(params[:id])
    @comment.destroy
    redirect_to @issue
  end

  private
    def comment_params
      params.require(:comment).permit(:user_full_name, :content)
    end
end
