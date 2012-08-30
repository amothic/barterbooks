class AddBooklogIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :booklog_id, :integer
  end
end
