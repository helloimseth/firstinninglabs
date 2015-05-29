class LogsController < ApplicationController

  def index
    @logs = Log.all
  end

  def show
    @log = Log.find(params[:id])
    @games = @log.games
  end
end
