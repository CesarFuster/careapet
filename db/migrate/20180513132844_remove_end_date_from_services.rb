class RemoveEndDateFromServices < ActiveRecord::Migration[5.1]
  def change
    remove_column :services, :end_date, :date
  end
end
