class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.integer :calorie
      t.integer :protein
      t.integer :fat
      t.integer :carbo
      t.integer :customer_id
      t.integer :category_id

      t.timestamps
    end
  end
end
