class TrackController < ApplicationController

  skip_before_action :verify_authenticity_token

  skip_before_action :root_account_required
  skip_before_action :session_user_required

  before_action :restrict_format
  before_action :restrict_access


  def entities
  end

  def events
  end

  private

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      if communication_key = CommunicationKey.where(access_token: token).take
        InputRequestCountJob.perform_later communication_key
      end
    end
  end

  def restrict_format
    head :bad_request unless params[:format] == 'json' || request.headers["Accept"] =~ /json/
  end

end
