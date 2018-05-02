class RemovePriceFromUserTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_tasks, :price, :string
  end
end
