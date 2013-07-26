class CreateDamagePhotos < ActiveRecord::Migration
  def change
    create_table :damage_photos do |t|
      t.string :file
      t.references :damageattachable, :polymorphic => true

      t.timestamps
    end
  end
end
