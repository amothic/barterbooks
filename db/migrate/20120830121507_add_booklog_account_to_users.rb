class AddBooklogAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :booklog_account, :string
  end
end
