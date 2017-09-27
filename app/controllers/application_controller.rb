class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def check_shutdown
    logout if current_user && current_user.shutdown?
  end
end
