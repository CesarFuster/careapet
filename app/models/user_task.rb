class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user

  monetize :price_cents

end
