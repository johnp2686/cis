class CreateEndUsers < ActiveRecord::Migration
  def change
    create_table :end_users do |t|
      t.string :first_name, :limit=> 50
      t.string :last_name, :limit=> 50
      t.string :email,:limit=> 35
      t.string :user_name
      t.date   :dob
      t.string :mobile
      t.string :gender
      t.string :location
      t.string :address
      t.integer :zip
      t.string :policy_number
      t.string :damage_details
      t.date   :date_of_damage
      t.integer :role_id
      t.integer :agent_id
      t.boolean :claims_status, :default => false 	
      t.timestamps
    end
  end
end
