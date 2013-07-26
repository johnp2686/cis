class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.string :age_of_item
      t.integer :price_paid
      t.integer :estimated_cost
      t.integer :replacement_cost
      t.integer :deductions_for_wear_and_tear
      t.integer :amount_claimed

      t.timestamps
    end
  end
end
