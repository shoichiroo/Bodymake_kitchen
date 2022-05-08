class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :amount
      t.integer :recipe_id

      t.timestamps
    end
  end
end
