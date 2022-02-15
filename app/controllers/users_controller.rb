class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[index new create]

  # GET /users or /users.json
  def index
    @users = User.all.sort_by(&:created_at)
    @current_user ||= User.find_by_id cookies.signed[:user_id]
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params.except(:password_conf)) if params[:password] == params[:password_conf]

    respond_to do |format|
      if @user.save
        @user.update_last_login
        format.html { redirect_to session_login_path, success: 'Пользователь успешно создан.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if params[:password] == params[:password_conf] && @user.update(user_params.except(:password_conf))
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Аккаунт был успешно удален' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:real_name, :nickname, :avatar, :password, :password_conf, :last_login)
  end
end
