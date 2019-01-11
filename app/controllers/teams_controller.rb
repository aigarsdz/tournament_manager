class TeamsController < ApplicationController
  def index
    teams = Team.all

    respond_to do |format|
      format.json { render json: teams }
    end
  end

  def create
    team_name = params[:team_name]
    division = Team.available_divisions.sample
    team = Team.create name: team_name, division: division

    respond_to do |format|
      format.json { render json: team }
    end
  end

  def destroy
    team = Team.find params[:id]

    team.destroy if team

    respond_to do |format|
      format.json { render json: "Team '#{team.name}' deleted" }
    end
  end
end
