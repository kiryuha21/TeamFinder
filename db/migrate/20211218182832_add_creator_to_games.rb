class AddCreatorToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :creator, :string
  end
end
