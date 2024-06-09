class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_comment, only: [:approve, :reject, :destroy]

	def create
	  @article = Article.find(params[:article_id])
	  @comment = @article.comments.new(comment_params)
	  @comment.user = current_user
	  @comment.approved = false

	  if @comment.save
		redirect_to @article, notice: 'Comment was successfully created.'
	  else
		redirect_to @article, alert: 'Error creating comment.'
	  end
	end

	def approve
	  if current_user == @comment.article.user
		@comment.update(approved: true)
		redirect_to @comment.article, notice: 'Comment approved!'
	  else
		redirect_to @comment.article, alert: 'You are not authorized to approve this comment.'
	  end
	end

	def reject
	  if current_user == @comment.article.user
		@comment.destroy
		redirect_to @comment.article, notice: 'Comment rejected and deleted.'
	  else
		redirect_to @comment.article, alert: 'You are not authorized to reject this comment.'
	  end
	end

	def destroy
	  if current_user == @comment.user
		@comment.destroy
		redirect_to @comment.article, notice: 'Comment was successfully deleted.'
	  else
		redirect_to @comment.article, alert: 'You are not authorized to delete this comment.'
	  end
	end

	private

	def set_comment
	  @comment = Comment.find(params[:id])
	end

	def comment_params
	  params.require(:comment).permit(:content)
	end
  end
