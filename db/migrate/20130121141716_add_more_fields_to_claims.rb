class AddMoreFieldsToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :is_home_or_any_part_lent_or_sublet, :boolean
    add_column :claims, :lent_or_sublet_description, :string
    add_column :claims, :damage_discovered_date, :date
    add_column :claims, :discovered_by, :string
    add_column :claims, :property_last_seen, :date
    add_column :claims, :property_last_seen_by, :string
    add_column :claims, :time_of_police_notified, :date
    add_column :claims, :police_reference, :string
    add_column :claims, :have_made_any_claim_before, :boolean
    add_column :claims, :claim_settlement_details, :string
    add_column :claims, :are_you_owner_of_lost, :boolean
    add_column :claims, :state_the_names_owner, :string
    add_column :claims, :occupied_home_as_tenant, :boolean
    add_column :claims, :are_you_responsible_for_tenancy_agreement, :boolean
    add_column :claims, :limit_of_responsibility, :string
    add_column :claims, :have_estimates, :boolean
    add_column :claims, :estimated_cost_of_repair, :integer
    add_column :claims, :actual_cost, :integer
    add_column :claims, :claiming_cost, :integer
    add_column :claims, :claim_number, :integer
  end
end
