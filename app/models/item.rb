class Item < ActiveRecord::Base
  attr_accessible :claim_id, :age_of_item, :amount_claimed, :deductions_for_wear_and_tear, :description, :estimated_cost, :price_paid, :replacement_cost
  belongs_to :claim
end
