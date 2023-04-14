class IssuesController < ApplicationController
  before_action :set_issue, only: %i[  edit update destroy ]

  # GET /issues or /issues.json
  def index
    @issues = Issue.all
  end

  # GET /issues/1 or /issues/1.json
  def show
    @issue = Issue.find(params[:id])
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  def create_issues_bulk
    issue_titles = params[:issue_titles]&.split("\n").map(&:strip)
    issue_titles.each do |issue|
      Issue.find_or_create_by(issue: issue, tipus: "Bug", severity: "Normal", priority: "Normal", status: "New", assign_to: "Not Assigned")
    end

    redirect_to issues_path
  end

  # POST /issues or /issues.json
  def create
    @issue = Issue.new(issue_params)

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
    @issue.issue_versions.destroy_all
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url, notice: "Issue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def issue_params
      params.require(:issue).permit(:tipus, :severity, :priority, :issue, :status, :assign_to, :due_date, :reason_due_date, :reason_block, :block_status)
    end
end
