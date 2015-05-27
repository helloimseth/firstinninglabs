class TeamsController < ApplicationController
  before_action :refresh_stats!

  def index
    @teams = Team.all
  end

  def show
    @team = Team.includes(bats: :statlines)
                .includes(pits: :statlines)
                .find(params[:id])
  end
end
