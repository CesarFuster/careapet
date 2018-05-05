class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  after_create :send_welcome_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
