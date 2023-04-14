class Issue < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many_attached :attachments
  validates :issue, presence: true
  before_update :save_issue_version
  has_many :issue_versions
  # ...

  private

  def save_issue_version
    self.changed_attributes.each do |attr, old_value|
      IssueVersion.create(
        issue: self,
        attribute_name: attr,
        old_value: old_value,
        new_value: self.send(attr),
        created_at_change: Time.current
      ) if old_value != self.send(attr)
    end
  end
end
