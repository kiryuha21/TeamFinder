class ApplicationController < ActionController::Base
  add_flash_types :success

  include SessionHelper
  include PostsHelper
  include CommentsHelper

  before_action :require_login
  before_action :game_cookies
  before_action :post_cookies
  before_action :set_locale

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
    @current_user&.update_last_login
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale.to_sym : nil
  end

  def post_cookies
    return if controller_name == 'comments'

    clean_post_cookies
  end

  def game_cookies
    return if controller_name == 'posts' || controller_name == 'comments'

    clean_game_cookies
  end

  def require_login
    return if signed_in?

    flash[:warning] = 'Login required'
    redirect_to session_login_url
  end
end
