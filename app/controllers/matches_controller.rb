class MatchesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json do
        response = {}

        Division.values.each do |division|
          response[division] = Match.where(division: division).order(id: :desc)
        end

        play_off_matches = Match.where(division: nil).order(id: :desc)

        response['play_off_matches'] = play_off_matches

        if play_off_matches.count > 0
          response['winner'] = Team.find play_off_matches.first.winner
        else
          response['winner'] = nil
        end

        render json: response
      end
    end
  end

  def create
    divisions = params[:divisions]
    response = {}
    play_off_teams = []

    Match.destroy_all

    divisions.each do |division|
      matches, leaderboard = create_division_matches_for division

      Match.create matches

      play_off_teams += leaderboard.collect { |team_id, team_info|
        [team_id, team_info[0], team_info[1]]
      }.max(4) { |first_team, second_team|
        first_team[1] <=> second_team[1]
      }

      response[division] = matches
    end

    play_off_matches = create_play_off_matches_for play_off_teams

    Match.create play_off_matches

    response['play_off_matches'] = play_off_matches
    response['winner'] = Team.find play_off_matches.last[:winner]

    respond_to do |format|
      format.json { render json: response }
    end
  end

  private
  AVAILABLE_SCORE_RANGE = 1..20

  def create_division_matches_for(division)
    teams = Team.where division: division
    results = []
    leaderboard = Hash[teams.collect { |team| [team.id, [0, team.name]] }]
    shuffled_teams = teams.shuffle
    first_half = teams[0..3]
    second_half = teams[4..7]

    first_half.each do |first_team|
      second_half.each do |second_team|
        if first_team != second_team
          first_score = rand(AVAILABLE_SCORE_RANGE)
          second_score = rand(AVAILABLE_SCORE_RANGE)

          # TODO: randomize correction!
          first_score += 1 if first_score == second_score

          results << {
            first_team: first_team.id,
            second_team: second_team.id,
            first_team_name: first_team.name,
            second_team_name: second_team.name,
            first_score: first_score,
            second_score: second_score,
            winner: first_score > second_score ? first_team.id : second_team.id,
            division: division
          }

          if first_score > second_score
            leaderboard[first_team.id][0] += 1
          else
            leaderboard[second_team.id][0] += 1
          end
        end
      end
    end

    return results, leaderboard
  end

  PAIR_COUNT = 4

  def create_play_off_matches_for(teams, pair_count = PAIR_COUNT)
    results = []
    winners = []

    return results if teams.count == 1

    sorted_teams = teams.sort { |first_team, second_team| first_team[1] <=> second_team[1] }

    sorted_teams.each_with_index do |team, index|
      pair_index = index + pair_count

      if pair_index < sorted_teams.count
        pair_team = sorted_teams[pair_index]
        first_score = rand(AVAILABLE_SCORE_RANGE)
        second_score = rand(AVAILABLE_SCORE_RANGE)

        # TODO: randomize correction!
        first_score += 1 if first_score == second_score
        winner = first_score > second_score ? team : pair_team

        results << {
          first_team: team[0],
          second_team: pair_team[0],
          first_team_name: team[2],
          second_team_name: pair_team[2],
          first_score: first_score,
          second_score: second_score,
          winner: winner[0]
        }

        winners << winner
      end
    end

    results += create_play_off_matches_for winners, pair_count / 2

    results
  end
end
