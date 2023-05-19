class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def update
    api_key = request.headers[:HTTP_X_API_KEY]
    if api_key.nil?
      render :json => { "status" => "401", "error" => "No Api key provided." }, status: :unauthorized and return
    else
      @APIuser = User.find_by_api_key(api_key)
      if @APIuser.nil?
        render :json => { "status" => "401", "error" => "No User found with the Api key provided." }, status: :unauthorized and return
      elsif @APIuser.id != @user.id
        render :json => { "status" => "401", "error" => "Only the user can edit himself." }, status: :unauthorized and return
      end
    end
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(usuario_params)
        format.html { redirect_to @user }
        format.json { render json: @user, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def timeline
    @user = User.find(params[:id])
    collected_issues = []
    Issue.where(created_by: @user.full_name).each do |issue|
      collected_issues << {
        user_full_name: @user.full_name,
        description: "has created",
        issue_id: issue.id,
        issue_title: issue.issue,
        issue_attribute: "null",
        at: issue.created_at
      }
    end
    IssueVersion.where(user_full_name: @user.full_name).reverse_order.each do |version|
      if version.attribute_name != "updated_at" && version.attribute_name != "user_name"
        collected_issues << {
          user_full_name: @user.full_name,
          description: "has updated",
          issue_id: version.issue.id,
          issue_title: version.issue.issue,
          issue_attribute: version.attribute_name,
          at: version.updated_at
        }
      end
    end
    sorted_issues = collected_issues.sort_by { |issue| issue[:at] }.reverse
    render json: { timeline: sorted_issues.presence || 'No timeline available' }
  end

  def watched
    @user = User.find(params[:id])
    watched_issues = @user.watched_issues

    watched_issues_data = watched_issues.map do |issue| {
      issue_id: issue.id, issue_name: issue.issue
    }
    end

    if watched_issues_data.present?
      render json: { watched_issues: watched_issues_data }
    else
      render json: { message: 'No watched issues found.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def usuario_params
    params.require(:user).permit(:full_name, :image, :bio)
    end

    def has_valid_api_key?
      request.headers['X-API-KEY'] == 'hola'
    end
end
