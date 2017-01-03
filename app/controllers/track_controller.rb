class TrackController < ApplicationController

  skip_before_action :verify_authenticity_token

  skip_before_action :root_account_required
  skip_before_action :session_user_required

  before_action :restrict_format
  before_action :restrict_access


  def entities
    params.permit!
    usable_params = params.except(:action, :controller, :format, :id)

    primary_attrs_hash = usable_params.select { |k, v| Entity::PRIMARY_ATTRS.include?(k) }
    head :not_acceptable and return if primary_attrs_hash.empty?

    @entity = @communication_key.app.entities.find_or_initialize_by(primary_attrs_hash)
    usable_params
        .select { |k, v| Entity::PRIMARY_ATTRS.exclude?(k) }
        .each do |k, v|
      entity_details = @entity.details.find_or_initialize_by(property_key: k)
      entity_details.attributes = {property_key: k, property_value: v}
      logger.debug entity_details.errors.inspect unless entity_details.save unless entity_details.new_record?
    end

    unless @entity.save
      head :not_acceptable
      logger.debug @entity.errors.inspect
    end
  end

  def events
  end

  private

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      if @communication_key = CommunicationKey.where(access_token: token).take
        InputRequestCountJob.perform_later @communication_key
      end
    end
  end

  def restrict_format
    head :bad_request unless params[:format] == 'json' || request.headers["Accept"] =~ /json/
  end

end
