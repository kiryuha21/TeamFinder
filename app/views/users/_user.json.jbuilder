json.extract! user, :id, :real_name, :nickname, :password_digest, :last_login, :avatar_link, :created_at, :updated_at
json.url user_url(user, format: :json)
