class AddPriceToUserTasks < ActiveRecord::Migration[5.1]
  def change
    add_monetize :user_tasks, :price, currency: { present: false }
  end
end
