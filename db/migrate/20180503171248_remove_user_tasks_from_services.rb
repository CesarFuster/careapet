class RemoveUserTasksFromServices < ActiveRecord::Migration[5.1]
  def change
    if foreign_key_exists?(:services, :user_tasks)
      remove_foreign_key :services, :user_tasks
    end
  end
end
