class Issue < ApplicationRecord
<<<<<<< HEAD
  has_many :comments, dependent: :destroy
=======
   has_many_attached:attachments
  # enum status: [:new, :in_progress, :ready_for_test, :closed, :needs_info, :rejected, :postponed]
  # enum priority: [:low, :normal, :high]
  # enum assign_to: [:Joel, :Alba, :Sergio, :Marc]
>>>>>>> feature14-add_list_delete_arxius
end
