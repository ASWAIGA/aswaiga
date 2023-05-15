class Issue < ApplicationRecord
  # enum status: [:new, :in_progress, :ready_for_test, :closed, :needs_info, :rejected, :postponed]
  # enum priority: [:low, :normal, :high]
  # enum assign_to: [:Joel, :Alba, :Sergio, :Marc]
  has_many :arxius, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :attachments
  validates :issue, presence: true
  before_update :save_issue_version
  has_many :issue_versions, dependent: :destroy
  #belongs_to :user, foreign_key: "created_by", primary_key: "full_name"
  #delegate :full_name, to: :user, prefix: true, allow_nil: true
  # ...
  has_and_belongs_to_many :watchers, class_name: 'User'
  private

  def save_issue_version
    self.changed_attributes.each do |attr, old_value|
      IssueVersion.create(
        issue: self,
        attribute_name: attr,
        old_value: old_value,
        new_value: self.send(attr),
        created_at_change: Time.current,
        user_full_name: self.user_name,
      ) if old_value != self.send(attr)
    end

  #after_save :update_created_by

  #def update_created_by
  #  self.created_by = user.full_name
  #  save
  #end

  end


end

