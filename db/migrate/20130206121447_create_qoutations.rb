class CreateQoutations < ActiveRecord::Migration
  def change
    create_table :qoutations do |t|

      t.timestamps
    end
  end
end
