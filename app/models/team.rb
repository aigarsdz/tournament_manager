class Team < ApplicationRecord
  def self.available_divisions
    teams = self.all
    stats = Hash[Division.values.collect { |division| [division, 0] }]
    divisions_with_less_than_eight_teams = []

    teams.each do |team|
      if stats.has_key?(team.division)
        stats[team.division] += 1
      end
    end

    stats.each do |division, team_count|
      divisions_with_less_than_eight_teams << division if team_count < 8
    end

    divisions_with_less_than_eight_teams
  end
end
