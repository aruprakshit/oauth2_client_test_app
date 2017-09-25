class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def not_authenticated
    flash[:warning] = 'You have to authenticate to access this page.'
    redirect_to log_in_path
  end
end
