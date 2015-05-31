class PitsController < ApplicationController

  def show
    @pit = Pit.find(params[:id])
    @teams = Team.all
  end

  def update
    @pit = Pit.find(params[:id])

    if @pit.update(team_id: params[:pit][:team_id])
      redirect_to pit_url(@pit)
    else
      render :show
    end
  end
end
