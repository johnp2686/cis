class CreateUserMails < ActiveRecord::Migration
  def change
    create_table :user_mails do |t|
      t.string :from
      t.string :to
      t.string :subject
      t.timestamps
    end
  end
end
