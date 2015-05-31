class BatsController < ApplicationController
  def show
    @bat =  Bat.includes(:statlines).find(params[:id])
    @teams = Team.all
  end

  def update
    @bat = Bat.find(params[:id])
    if @bat.update(team_id: params[:bat][:team_id])
      redirect_to bat_url(@bat)
    else
      render :show
    end
  end
end
