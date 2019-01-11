class AddGameTypeToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :results, :game_type, :integer
  end
end
