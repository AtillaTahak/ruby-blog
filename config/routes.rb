Rails.application.routes.draw do
	devise_for :users
	root 'welcome#index'

	resources :articles do
	  member do
		post :like
		post :unlike
	  end

	  resources :comments, only: [:create, :destroy] do
		member do
		  patch :approve
		  delete :reject
		end
	  end
	end

	resources :users, only: [:show, :edit, :update]
  end
