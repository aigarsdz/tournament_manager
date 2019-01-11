class AddTeamNamesToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :first_team_name, :string
    add_column :matches, :second_team_name, :string
  end
end
