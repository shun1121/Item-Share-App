class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :name
      t.string :thumbnail
      t.string :price
      t.string :introduction

      t.timestamps
    end
  end
end
