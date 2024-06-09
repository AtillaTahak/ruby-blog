class UsersController < ApplicationController
	before_action :authenticate_user!

	def show
	  @user = User.find_by(nickname: params[:id])
	  @articles = @user.articles
	  @pending_comments = Comment.joins(:article).where(articles: { user_id: @user.id }, approved: false)
	  @approved_comments = @user.comments.where(approved: true)
	  @pending_self_comments = @user.comments.where(approved: false)
	end

	def edit
	  @user = User.find_by(nickname: params[:id])
	end

	def update
	  @user = User.find_by(nickname: params[:id])
	  if @user.update(user_params)
		redirect_to user_path(@user.nickname), notice: 'Profile updated successfully.'
	  else
		render :edit
	  end
	end

	private

	def user_params
	  params.require(:user).permit(:nickname, :email)
	end
  end
