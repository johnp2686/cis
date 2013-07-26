class CreateSentstatuses < ActiveRecord::Migration
  def change
    create_table :sentstatuses do |t|
    	t.integer :user_id
	    t.integer :claim_id
        t.string :from
        t.string :to
        t.string :subject
        t.string :message
        t.timestamps

      t.timestamps
    end
  end
end
