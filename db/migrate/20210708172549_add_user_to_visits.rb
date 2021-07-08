class AddUserToVisits < ActiveRecord::Migration[6.1]
  def change
    add_column :visits, :user, :integer
  end
end
