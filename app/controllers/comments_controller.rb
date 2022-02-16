# frozen_string_literal: true

# main class for comments
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :check_post, except: :index
  skip_before_action :require_login, only: :index

  # GET /comments or /comments.json
  def index
    _set_post params[:post]
    @comments = current_post.comments.all.sort_by(&:created_at)
    @current_user ||= User.find_by_id cookies.signed[:user_id]
  end

  # GET /comments/1 or /comments/1.json
  def show; end

  # GET /comments/new
  def new
    @comment = current_post.comments.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments or /comments.json
  def create
    @comment = current_post.comments.new(text: params[:text])
    @comment.user_id = @current_user.id
    @comment.author = @current_user.nickname

    respond_to do |format|
      if @comment.save
        format.html { redirect_to comment_url(@comment) }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comments_path }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def check_post
    return if post_set?

    flash[:warning] = 'Сначала выберите публикацию'
    redirect_to post
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:author, :author_id_id, :post_id, :text)
  end
end
