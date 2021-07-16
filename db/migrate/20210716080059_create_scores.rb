class CreateScores < ActiveRecord::Migration[5.2]

  def change
    create_table :scores do |t|
      t.references :user, foreign_key: true
      t.references :character, foreign_key: true
      t.references :stage, foreign_key: true
      t.integer :point, default: 0
      t.timestamps
    end
  end

end
