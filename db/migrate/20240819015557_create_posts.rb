class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :store_name
      t.string :beans_name
      t.integer :roast_level
      t.string :coffee_growing_regions
      t.text :photo
      t.text :memo

      t.timestamps
    end
  end
end
