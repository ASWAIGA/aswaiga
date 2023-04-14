class Issue < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many_attached :attachments
  validates :issue, presence: true
end
