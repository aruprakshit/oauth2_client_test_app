class DataController < ApplicationController
  def index
    oauth_token = Rails.configuration.oauth_credentials['oauth_token']
    oauth_secret = Rails.configuration.oauth_credentials['oauth_secret']
    oauth_redirect_uri = Rails.configuration.oauth_credentials['oauth_redirect_uri']
    oauth_provider_url = Rails.configuration.oauth_credentials['oauth_provider_url']

    if session[:current_access_token]
      @data = HTTParty.get "#{oauth_provider_url}/api/v1/users.json", { query: { access_token: session[:current_access_token]} }
    else
      redirect_to "#{oauth_provider_url}/oauth/authorize?client_id=#{oauth_token}&redirect_uri=#{oauth_redirect_uri}&response_type=code"
    end
  end

  def create_session
    oauth_token = Rails.configuration.oauth_credentials['oauth_token']
    oauth_secret = Rails.configuration.oauth_credentials['oauth_secret']
    oauth_redirect_uri = Rails.configuration.oauth_credentials['oauth_redirect_uri']
    oauth_provider_url = Rails.configuration.oauth_credentials['oauth_provider_url']

    req_params = "client_id=#{oauth_token}&client_secret=#{oauth_secret}&code=#{params[:code]}&grant_type=authorization_code&redirect_uri=#{oauth_redirect_uri}"
    response = HTTParty.post("#{oauth_provider_url}/oauth/token", body: req_params)
    session[:current_access_token] = response['access_token']
    redirect_to root_path
  end
end
