class CreateProcedures < ActiveRecord::Migration[6.1]
  def change
    create_table :procedures do |t|
      t.text :description
      t.integer :recipe_id

      t.timestamps
    end
  end
end
