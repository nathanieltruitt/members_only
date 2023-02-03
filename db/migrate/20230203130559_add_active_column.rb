class AddActiveColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :active, :boolean, default: true
  end
end
