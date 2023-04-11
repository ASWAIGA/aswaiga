class IssuesController < ApplicationController
  before_action :set_issue, only: %i[ show edit update destroy  ]

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
        @issues = @issues.where("subject LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
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
  end

  # GET /issues/1 or /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues or /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to issue_url(@issue), notice: "Issue was successfully created." }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1 or /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to issue_url(@issue), notice: "Issue was successfully updated." }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_attachments
    @issue_interessa = Issue.find(params[:id])
    @issue_interessa.attachments.purge;
    redirect_to @issue_interessa
  end

  # DELETE /issues/1 or /issues/1.json
  def destroy
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url, notice: "Issue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def delete_attachment
    @issue_interessa = Issue.find(params[:id])
    @issue_interessa.attachments.purge
    redirect_to @issue_interessa
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def issue_params
      params.require(:issue).permit(:tipus, :severity, :priority, :issue, :status, :assign_to, :subject, :description, attachments: [])
    end
end
