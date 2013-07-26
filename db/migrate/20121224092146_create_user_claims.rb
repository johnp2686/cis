class CreateUserClaims < ActiveRecord::Migration
  def change
    create_table :user_claims do |t|
      t.integer :user_id
      t.integer :claim_id

      t.timestamps
    end
  end
end
