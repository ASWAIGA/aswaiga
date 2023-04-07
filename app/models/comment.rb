class Comment < ApplicationRecord
  belongs_to :issue, dependent: :destroy
  validates :content, presence: true
end
