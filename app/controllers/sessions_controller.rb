class SessionsController < ApplicationController

  skip_before_action :root_account_required, only: [:account_signup]
  skip_before_action :session_user_required, only: [:account_signup, :login]

  before_action :restricted_for_root_account, only: [:account_signup]

  def login
    if request.post?
      if (user = root_account.users
                     .find_by(email: params[:user][:email])
                     .try(:authenticate, params[:user][:password]))

        session[:user_id] = user.id
        redirect_to(dashboard_path, notice: "Welcome #{current_user.name}")
      else
        flash[:alert]= 'Invalid credentials provided. Please try again with correct credentials'
      end
    end
  end

  def logout
    reset_session
    session[:user_id].try(:delete)
    redirect_to root_path
  end

  def account_signup
    if request.get?
      @account = Account.new
      @account.users.build
    elsif request.post?
      @account = Account.new(account_signup_params)
      if @account.save
        flash[:notice] = 'Account created successfully'
      else
        logger.info @account.errors.inspect
        flash[:alert] = 'Failed to create account. Look up form for error details'
      end
    end
  end

  private
  def account_signup_params
    params.require(:account).permit(:name, :subdomain, users_attributes: [:name, :email, :password])
  end

end
