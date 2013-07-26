class AddClaimStatusToClaim < ActiveRecord::Migration
  def change
    add_column :claims, :claim_status, :string
  end
end
