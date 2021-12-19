class ApplicationController < ActionController::Base
  add_flash_types :success
  include SessionHelper
  include PostsHelper

  before_action :require_login
  before_action :game_cookies

  private

  def game_cookies
    return if controller_name == 'posts'

    clean_cookies
  end

  def require_login
    return if signed_in?

    flash[:warning] = 'Login required'
    redirect_to session_login_url
  end
end
