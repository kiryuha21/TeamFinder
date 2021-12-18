class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :creator

      t.timestamps
    end
    add_index :games, :name, unique: true
  end
end
