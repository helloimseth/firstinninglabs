class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.includes(bats: :statlines)
                .includes(pits: :statlines)
                .find(params[:id])
  end
end
