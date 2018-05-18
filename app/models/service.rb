class Service < ApplicationRecord
  has_one :user
  has_one :order
  has_many :user_tasks, through: :user
  has_many :items, dependent: :destroy
  belongs_to :buyer, class_name: 'User'
  belongs_to :caregiver, class_name: 'User'

  monetize :price_cents

  validates :period, inclusion: { in: ['9h - 10h', '10h - 11h','11h - 14h', '15h - 16h ', '16h - 17h']}

  def available?(date, period)
    is_service_available = []
    caregiver.caregiver_services.select do |caregiver_service|
      if caregiver_service.date == date && caregiver_service.period == period
        is_service_available << caregiver_service
        return is_service_available.nil?
      end
    end
  end

  def total_value(user, user_task_ids)
    user_task_ids.each do |id|
      id.to_i
    end
    user_task_values = []
    user_task_values << user.user_tasks.where(id: id)
      return user_task_values.sum(&:price)
  end

  def service_items(user, user_task_ids)
    ids = user_task_ids
    ids.each do |id|
      user_tasks = []
      user_tasks << user.user_tasks.where(id: id)
      item = Item.new(
        service: @service,
        price: user_task.price,
        description: user_task.task.name
      )
      item.save!
      items = []
      items << item
    end
    return items
  end

end





