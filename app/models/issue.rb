class Issue < ApplicationRecord
   has_many_attached:attachments
  # enum status: [:new, :in_progress, :ready_for_test, :closed, :needs_info, :rejected, :postponed]
  # enum priority: [:low, :normal, :high]
  # enum assign_to: [:Joel, :Alba, :Sergio, :Marc]
end
