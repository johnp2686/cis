class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.string :quotation

      t.timestamps
    end
  end
end
