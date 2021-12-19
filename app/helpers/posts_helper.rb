module PostsHelper
  def _set_game(game)
    return unless params[:game]

    cookies[:current_game] = { value: game }
  end

  def clean_game_cookies
    cookies[:current_game] = nil
  end

  def game_set?
    !cookies[:current_game].nil?
  end

  def current_game=(game)
    @current_game = game
  end

  def current_game
    @current_game ||= Game.find_by_name cookies[:current_game]
  end
end
