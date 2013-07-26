class AddEmpIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :emp_id, :integer
  end
end
