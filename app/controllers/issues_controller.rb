class IssuesController < ApplicationController
  before_action :set_issue, only: %i[  edit update destroy ]
  skip_before_action :verify_authenticity_token


  # GET /issues or /issues.json
  def index
    # @issues = Issue.all
    # @issues = issues.where(status: params[:status]) if params[:status].present?
    # @issues = issues.where(priority: params[:priority]) if params[:priority].present?
    # @issues = issues.where(assign_to: params[:assign_to]) if params[:assign_to].present?
    # @issues = issues.where(assignee: params[:assignee]) if params[:assignee].present?
    # @issues = issues.where(tags: params[:tags]) if params[:tags].present?
    # @issues = issues.where(created_by: params[:created_by]) if params[:created_by].present?

     @issues = Issue.all
     if params[:search]
       if params[:search].present?
        @issues = @issues.where("issue LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      else
        @issues = @issues
      end
    end

     if params[:sort].present?
        case params[:sort]
        when 'status_asc'
          @issues = @issues.order(status: :asc)
        when 'priority_asc'
          @issues = @issues.order(priority: :asc)
        when 'assign_to_asc'
          @issues = @issues.order(assign_to: :asc)
        when 'assignee_asc'
          @issues = @issues.order(assignee: :asc)
        when 'created_by_asc'
          @issues = @issues.order(created_by: :asc)
        end
      end

      if params[:filter_status]
          if params[:filter_status]
            @issues = @issues.where("status LIKE ?", "%#{params[:filter_status]}%")
          end
      end
      if params[:filter_priority]
          if params[:filter_priority]
            @issues = @issues.where("priority LIKE ?", "%#{params[:filter_priority]}%")
          end
      end
      if params[:filter_assign_to]
       if params[:filter_assign_to].present?
        @issues = @issues.where("assign_to LIKE ?", "%#{params[:filter_assign_to]}%")
       end
      end

      if params[:filter_assignee]
       if params[:filter_assignee].present?
        @issues = @issues.where("assignee LIKE ?", "%#{params[:filter_assignee]}%")
       end
      end

      if params[:filter_created_by]
       if params[:filter_created_by].present?
        @issues = @issues.where("created_by LIKE ?", "%#{params[:filter_created_by]}%")
       end
      end
  end

  # GET /issues/1 or /issues/1.json
  def show
    @issue = Issue.find(params[:id])
  end

  # GET /issues/new
  def new
    @issue = Issue.new
    if current_user
      @issue.created_by = current_user.full_name
    end
  end

  # GET /issues/1/edit
  def edit
  end

  def create_issues_bulk
    issue_titles = Array(params[:issue_titles])&.map(&:strip)

    if issue_titles.present?
      issue_titles.each do |issue|
        Issue.find_or_create_by(issue: issue, tipus: "Bug", severity: "Normal", priority: "Normal", status: "New", assign_to: "Not Assigned")
      end
    end
    redirect_to issues_path
  end

  # POST /issues or /issues.json
  def create
    @issue = Issue.new(issue_params)
    if current_user
      @issue.created_by = current_user.full_name
    end
    respond_to do |format|
      if params[:block_clicked] == 'true'
        if @issue.update(block_status: true)
          format.html { redirect_to issue_url(@issue), notice: "Issue blocked was successfully created." }
          format.json { render :show, status: :ok, location: @issue }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @issue.errors, status: :unprocessable_entity }
        end
      else
        if @issue.save
          format.html { redirect_to issue_url(@issue), notice: "Issue was successfully created." }
          format.json { render :show, status: :created, location: @issue }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @issue.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /issues/1 or /issues/1.json
  def update
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
    respond_to do |format|
      if params[:unblock_clicked] == 'true'
        if @issue.update(reason_block: nil, block_status: false)
          format.html { redirect_to issue_url(@issue), notice: "Issue unblocked." }
          format.json { render :show, status: :ok, location: @issue }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @issue.errors, status: :unprocessable_entity }
        end
      elsif params[:block_clicked] == 'true'
        if @issue.update(block_status: true, reason_block: params[:issue][:reason_block])
          format.html { redirect_to issue_url(@issue), notice: "Issue blocked." }
          format.json { render :show, status: :ok, location: @issue }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @issue.errors, status: :unprocessable_entity }
        end
      else
        if @issue.update(issue_params)
          format.html { redirect_to issue_url(@issue), notice: "Issue was successfully updated." }
          format.json { render :show, status: :ok, location: @issue }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @issue.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /issues/1 or /issues/1.json
  def destroy
    @issue = Issue.find(params[:id])
    @issue.issue_versions.destroy_all
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url, notice: "Issue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_watcher
    @issue = Issue.find(params[:id])
    @user = current_user
    @issue.watchers << @user
    redirect_to @issue
  end

  def get_watchers
    @issue = Issue.find(params[:id])
    render json: @issue.watchers
  end

  def add_watchers
    @issue = Issue.find(params[:id])
    if params[:user_ids].present?
      @users = User.where(id: params[:user_ids])
      @issue.watchers << @users
    end
    redirect_to @issue
  end


  def remove_watcher
  @issue = Issue.find(params[:id])
  @user = User.find(params[:user_id])
  @issue.watchers.delete(@user)
  redirect_to @issue
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def issue_params
      params.require(:issue).permit(:tipus, :severity, :priority, :issue, :status, :assign_to, :assignee, :created_by, :due_date, :reason_due_date, :reason_block, :block_status, :user_name, :description, attachments: [])
    end
end
