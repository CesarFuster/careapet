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
    this_service_user_tasks = []
    user_task_ids.each do |id|
      this_service_user_tasks << UserTask.where(task: id.to_i).merge(user_id: user)
    end
    return this_service_user_tasks.sum(&:price)
  end


  def service_items(user_task_ids)
    items = []
    user_task_ids.each do |id|
      user_task << UserTask.where(task: id.to_i)
    end

    items = user_task_params[:user_task_ids].drop(1)
    items.each do |item|
      user_task = UserTask.where(task: item.to_i).take
      item = Item.new(
        service: @service,
        price: user_task.price,
        description: user_task.task.name
        )
      item.save!
    end
  end

end



