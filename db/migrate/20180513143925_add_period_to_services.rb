class AddPeriodToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :period, :string
  end
end
