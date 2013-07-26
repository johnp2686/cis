class AddOtherFieldsToClaim < ActiveRecord::Migration
  def change
    add_column :claims, :is_damage_occur_your_home, :boolean
    add_column :claims, :damage_at_home_description_details, :string
    add_column :claims, :are_you_registered_for_VAT, :boolean
    add_column :claims, :are_estimates_sent_late_date, :boolean
  end
end
