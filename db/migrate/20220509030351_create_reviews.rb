class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :star
      t.integer :customer_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
