class GamesController < ApplicationController
  def new
    @game = Game.new
    @favorite = Competitor.new
    @underdog = Competitor.new
    @teams = Team.all
  end

  def create
    @game = Game.new(game_params)
    @game.favorite = Competitor.new(team_id: params[:favorite_id])
    @game.underdog = Competitor.new(team_id: params[:underdog_id])

    if @game.save
      redirect_to game_url(@game)
    else
      render :new
    end
  end

  def show
    @game = Game.includes({favorite: :team}, {underdog: :team})
                .find(params[:id])
    @favorite = @game.favorite
    @underdog = @game.underdog
  end

  private

    def game_params
      params.require(:game).permit(:date, :sportsbook_odds)
    end
end
