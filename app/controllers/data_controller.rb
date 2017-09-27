class DataController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :check_shutdown, only: [:index]
  before_action :authenticate_with_token, only: [:shutdown]

  def index
    oauth_provider_url = Rails.configuration.oauth_credentials['oauth_provider_url']

    @data = HTTParty.get "#{oauth_provider_url}/api/v1/users.json", {query: {access_token: current_user.current_access_token}}
  end

  def create_session
    oauth_token = Rails.configuration.oauth_credentials['oauth_token']
    oauth_secret = Rails.configuration.oauth_credentials['oauth_secret']
    oauth_redirect_uri = Rails.configuration.oauth_credentials['oauth_redirect_uri']
    oauth_provider_url = Rails.configuration.oauth_credentials['oauth_provider_url']
    public_key = Base64.urlsafe_decode64(params[:key])
    email = params[:email]

    if user = User.find_by(email: email)
      req_params = "client_id=#{oauth_token}&client_secret=#{oauth_secret}&code=#{params[:code]}&grant_type=authorization_code&redirect_uri=#{oauth_redirect_uri}"
      response = HTTParty.post("#{oauth_provider_url}/oauth/token", body: req_params)
      user.update_attributes public_key: public_key, current_access_token: params[:code]
      auto_login(user)

      redirect_to datas_path
    else
      redirect_to "#{oauth_provider_url}/oauth/authorize?client_id=#{oauth_token}&redirect_uri=#{oauth_redirect_uri}&response_type=code"
    end
  end

  def shutdown
    oauth_provider_url = Rails.configuration.oauth_credentials['oauth_provider_url']
    @user.update_attribute :shutdown, true
    redirect_to oauth_provider_url
  end

  protected
    def authenticate_with_token
      @user ||= User.find_by(current_access_token: params[:token])

      if @user && params[:signature].present?
        @user.valid_signature?(Base64.urlsafe_decode64(params[:signature]))
      else
        false
      end
    end
end
