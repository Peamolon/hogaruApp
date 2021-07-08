class ChangeStringBoolean < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :seen, :boolean
  end
end
