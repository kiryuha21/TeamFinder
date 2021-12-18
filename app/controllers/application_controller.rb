class ApplicationController < ActionController::Base
  add_flash_types :success
  include SessionHelper

  before_action :require_login

  private

  def require_login
    return if signed_in?

    flash[:warning] = 'Login required'
    redirect_to session_login_url
  end
end
