class RemovePriceCentsFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :price_cents, :money
  end
end
