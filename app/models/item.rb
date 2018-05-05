class Item < ApplicationRecord
  belongs_to :service
  monetize :price_cents
end
