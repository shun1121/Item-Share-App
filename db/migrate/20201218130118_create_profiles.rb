class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name
      t.string :thumbnail
      t.date :birthday

      t.timestamps
    end
  end
end
