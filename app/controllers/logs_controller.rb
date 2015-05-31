class LogsController < ApplicationController

  def index
    @logs = Log.all
  end

  def show
    @log = Log.find(params[:id])
    @games = @log.games
  end

  def new
    @last_log = Log.last || Log.new(day: 0, beginning_balance: 0)
    @log = Log.new
  end

  def create
    if Log.create!(log_params)
      redirect_to logs_url
    else
      render :new
    end
  end

  private

    def log_params
      params.require(:log).permit(:day, :date, :beginning_balance, :kelly)
    end
end
