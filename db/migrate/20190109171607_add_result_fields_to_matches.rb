class AddResultFieldsToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :first_team, :integer
    add_column :matches, :second_team, :integer
    add_column :matches, :first_score, :integer
    add_column :matches, :second_score, :integer
    add_column :matches, :winner, :integer

    add_index :matches, :first_team
    add_index :matches, :second_team

    drop_table :results
  end
end
