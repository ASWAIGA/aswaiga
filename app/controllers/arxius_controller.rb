class ArxiusController < ApplicationController
  before_action :set_issue

  def create
    @arxiu = @issue.arxius.create(arxiu_params)
    redirect_to @issue
  end

  def destroy
    @arxiu = @issue.arxius.find(params[:id])
    @arxiu.destroy
    redirect_to @issue
  end

  private

  def set_issue
    @issue = Issue.find(params[:issue_id])
  end

  def arxiu_params
    params.require(:arxiu).permit(:file)
  end
end
