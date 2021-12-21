module TestsHelper
def create_user
  @user = User.new(real_name: 'Кирилл', nickname: 'kiryuha12', password_digest: '1234')
  @nickname = Faker::Name.first_name
  post users_url,
       params: { user: { nickname: @nickname, password_conf: @user.password_digest,
                         password: @user.password_digest, real_name: @user.real_name } }
  post session_create_url, params: { user: @nickname, password: @user.password_digest }
  @user = User.find_by_nickname @nickname
end

def save_game
  @game_title = Faker::Game.title
  post games_url, params: { game: { name: @game_title, creator: @nickname } }
  @game = Game.find_by_name @game_title
end

def create_post
  @post_title = Faker::Game.title
  post posts_url, params: { post: { title: @post_title } }
  @post = Post.find_by_title @post_title
end
end
