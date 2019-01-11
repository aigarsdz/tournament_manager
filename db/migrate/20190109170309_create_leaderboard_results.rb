class CreateLeaderboardResults < ActiveRecord::Migration[5.2]
  def change
    create_table :leaderboard_results do |t|
      t.integer :team_id
      t.integer :team_score
      t.timestamps
    end
  end
end
