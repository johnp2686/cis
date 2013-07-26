class CreatePolicyPhotos < ActiveRecord::Migration
  def change
    create_table :policy_photos do |t|
      t.integer :claim_id
      t.string :file
      t.references :attachable, :polymorphic => true

      t.timestamps
    end
   # add_index :policy_photos, :attachable_id
  end
end
