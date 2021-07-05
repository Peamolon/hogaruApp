class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.date :expire
      t.string :seen

      t.timestamps
    end
  end
end
