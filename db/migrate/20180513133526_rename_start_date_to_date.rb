class RenameStartDateToDate < ActiveRecord::Migration[5.1]
  def change
    rename_column :services, :start_date, :date
  end
end
