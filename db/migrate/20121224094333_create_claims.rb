class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :policy_number
      t.date :date_of_loss
      t.string :location_of_loss
      t.string :claim_description
      t.string :damage_details

      t.timestamps
    end
  end
end
