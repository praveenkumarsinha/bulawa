class HomeController < ApplicationController

  skip_before_action :root_account_required, only: [:index]
  skip_before_action :session_user_required, only: [:index]

  before_action :restricted_for_root_account, only: [:index]

  def index
    redirect_to(dashboard_path) if root_account
  end

  def dashboard
  end

end
