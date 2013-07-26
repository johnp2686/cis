class AddMessageToUserMails < ActiveRecord::Migration
  def change
  	add_column :user_mails, :message, :string
  end
end
