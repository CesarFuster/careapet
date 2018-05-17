class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :task, uniqueness: true
  monetize :price_cents
end
