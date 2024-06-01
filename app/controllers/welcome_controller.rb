class WelcomeController < ApplicationController
	def index
		@articles = Article.where(published: true).select(:id, :title)
	end
end
