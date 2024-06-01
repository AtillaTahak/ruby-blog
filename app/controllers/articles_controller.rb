class ArticlesController < ApplicationController
	before_action :set_article, only: %i[show edit update destroy]
	before_action :check_if_published, only: %i[edit update destroy]

	def index
	  @articles = Article.all
	end

	def show
	end

	def new
	  @article = Article.new
	end

	def edit
	end

	def create
	  @article = Article.new(article_params)
	  if @article.save
		redirect_to @article, notice: 'Article was successfully created.'
	  else
		render :new
	  end
	end

	def update
	  if @article.update(article_params)
		redirect_to @article, notice: 'Article was successfully updated.'
	  else
		render :edit
	  end
	end

	def destroy
	  @article.destroy
	  redirect_to articles_path, notice: 'Article was successfully deleted.'
	end

	private

	def set_article
	@article = Article.find(params[:id])
	end

	def article_params
	params.require(:article).permit(:title, :content, :published)
	end

	def check_if_published
	return unless @article.published?

	redirect_to @article, alert: 'You cannot edit or delete a published article.'
	end
  end
