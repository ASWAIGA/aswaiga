class AttachmentsController < ApplicationController

def purge
  @issue_interessa = Issue.find(params[:id])
  @issue_interessa.attachments.purge
  redirect_to @issue_interessa
end

end
