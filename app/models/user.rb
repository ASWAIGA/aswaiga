class User < ApplicationRecord
  has_many :issues
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

         has_one_attached :image
  has_and_belongs_to_many :watched_issues, class_name: 'Issue'
  before_create :set_api_key
 def self.from_omniauth(auth)
   where(uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     user.full_name = auth.info.name
   end
 end

  def generate_api_key
    SecureRandom.base58(24)
  end

  def set_api_key
    self.api_key = generate_api_key
  end
end
