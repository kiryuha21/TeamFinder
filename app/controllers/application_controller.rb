class ApplicationController < ActionController::Base
  add_flash_types :success
  include SessionHelper
  include PostsHelper
  include CommentsHelper

  before_action :require_login
  before_action :game_cookies
  before_action :post_cookies

  private

  def post_cookies
    return if controller_name == 'comments'

    clean_post_cookies
  end

  def game_cookies
    return if controller_name == 'posts'

    clean_game_cookies
  end

  def require_login
    return if signed_in?

    flash[:warning] = 'Login required'
    redirect_to session_login_url
  end
end
