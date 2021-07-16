class CreateCharacters < ActiveRecord::Migration[5.2]

  def change
    create_table :characters do |t|
      t.string :name
      t.string :image
      t.integer :category
      t.integer :action_type
      t.timestamps
    end
  end

end
