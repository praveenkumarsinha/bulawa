class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :root_account_required
  before_action :session_user_required

  helper_method :root_account
  helper_method :current_user

  attr_accessor :root_account
  attr_accessor :current_user


  def current_user
    @current_user ||= (root_account ? root_account.users.where(id: session[:user_id]).take : nil)
  end

  def root_account
    @root_account ||= Account.where(subdomain: request.subdomains.first).take
  end

  private

  def session_user_required
    redirect_to(login_sessions_path, notice: 'Please login to continue') and return if current_user.nil?
  end

  def root_account_required
    redirect_to(root_url, notice: 'Unable to fetch account.') and return if root_account.nil?
  end

  def restricted_for_root_account
    redirect_to(dashboard_path, notice: 'Restricted access! Denied for account(subdomain).') and return if root_account
  end

end
