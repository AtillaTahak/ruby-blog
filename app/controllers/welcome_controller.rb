class WelcomeController < ApplicationController
	def index
		@articles_exist = Article.exists?
	end
end
