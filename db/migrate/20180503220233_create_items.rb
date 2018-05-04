class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.money :price_cents
      t.string :description
      t.references :service, foreign_key: true

      t.timestamps
    end
  end
end
