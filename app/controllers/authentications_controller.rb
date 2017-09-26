class AuthenticationsController < ApplicationController
  private

  def not_authenticated
    flash[:warning] = 'You have to authenticate to access this page.'
    redirect_to log_in_path
  end

  def check_shudtdown
    logout if current_user.shutdown?
  end
end
