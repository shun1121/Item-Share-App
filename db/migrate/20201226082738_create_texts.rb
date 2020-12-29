class CreateTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :texts do |t|
      t.text :content
      t.integer :user_id
      t.integer :post_id
      t.string :name

      t.timestamps
    end
  end
end
