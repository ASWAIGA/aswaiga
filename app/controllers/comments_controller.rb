class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @user = current_user
    api_key = request.headers[:HTTP_X_API_KEY]
    if api_key.nil?
      render :json => { "status" => "401", "error" => "No Api key provided." }, status: :unauthorized and return
    else
      @APIuser = User.find_by_api_key(api_key)
      if @APIuser.nil?
        render :json => { "status" => "401", "error" => "No User found with the Api key provided." }, status: :unauthorized and return
      else
        @user = @APIuser
      end
    end
    @issue = Issue.find(params[:issue_id])
    @comment = @issue.comments.create(comment_params)
    redirect_to @issue
  end

  def index
    @comments = Comment.where(issue_id: params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def show
    @issue = Issue.find(params[:issue_id])
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
