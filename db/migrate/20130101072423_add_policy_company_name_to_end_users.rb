class AddPolicyCompanyNameToEndUsers < ActiveRecord::Migration
  def change
  	add_column :end_users, :policy_company_name, :string
  end
end
