class DropLeaderboardResultsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :leaderboard_results
  end
end
