class CompetitorsController < ApplicationController
  def edit
    @competitor = Competitor.includes(team: { pits: :statlines })
                            .find(params[:id])
    @team = @competitor.team
  end

  def update
    @competitor = Competitor.find(params[:id])
    if @competitor.update(competitor_params)
      unless params[:sp_overwrite].blank?
        @competitor.sp_expected_war = params[:sp_overwrite]
        @competitor.save!
      end

      redirect_to game_url(@competitor.game)
    else
      render :edit
    end
  end

  def show
  end

  private

    def competitor_params
      params.require(:competitor).permit(:starter, batting_order: [],
                                          relievers: [])
    end
end
