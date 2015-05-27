class TeamsController < ApplicationController
  before_action :check_stats
  
  def index
    @teams = Team.all
  end

  def show
    @team = Team.includes(bats: :statlines)
                .includes(pits: :statlines)
                .find(params[:id])
  end

  private
    def check_stats
      if PitStatline.last.created_at < Date.yesterday ||
         BatStatline.last.created_at < Date.yesterday
         Pit.refresh_stats!
         Bat.refresh_stats!
       end
    end
end
