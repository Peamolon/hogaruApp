class AddVisitToPost < ActiveRecord::Migration[6.1]
  def change
    add_reference :visits, :post_id, null: false, foreign_key: { to_table: :posts }, index: true
  end
end
