class AddFieldsToClaims < ActiveRecord::Migration
  def change
  	add_column :claims, :policy_document, :string
  	add_column :claims, :damage_photo, :string
  	add_column :claims, :policy_worth, :integer
  	add_column :claims, :monthly_premium, :integer
  end
end
