class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  after_create :send_welcome_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  has_many :reviews, dependent: :destroy
  has_many :pets, dependent: :destroy
  has_many :user_tasks
  has_many :tasks, through: :user_tasks
  has_many :orders

  belongs_to :service, optional: true
  has_many :buyer_services, class_name: 'Service', foreign_key: 'buyer_id'
  has_many :caregiver_services, class_name: 'Service', foreign_key: 'caregiver_id'

  acts_as_votable
  acts_as_voter

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true

  mount_uploader :photo, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

end
