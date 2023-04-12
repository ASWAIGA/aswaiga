class Issue < ApplicationRecord
  has_many :comments, dependent: :destroy
end
