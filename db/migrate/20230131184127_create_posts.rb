class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.timestamps
    end
    add_reference :posts, :users, foreign_key: true
  end
end
