class BatsController < ApplicationController
  def show
    @bat =  Bat.includes(:statlines).find(params[:id])
  end
end
