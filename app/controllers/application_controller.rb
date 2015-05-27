class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def refresh_stats!
    if PitStatline.last.nil? || BatStatline.last.nil? ||
       PitStatline.last.created_at < Date.yesterday ||
       BatStatline.last.created_at < Date.yesterday
       Pit.refresh_stats!
       Bat.refresh_stats!
     end
  end
end
