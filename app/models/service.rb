class Service < ApplicationRecord
  has_one :user
  has_one :order
  has_many :user_tasks, through: :user
  has_many :items, dependent: :destroy
  belongs_to :buyer, class_name: 'User'
  belongs_to :caregiver, class_name: 'User'

  monetize :price_cents

  validates :period, inclusion: { in: ['9h - 10h', '10h - 11h','11h - 14h', '15h - 16h ', '16h - 17h']}

end



