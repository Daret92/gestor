Rails.application.routes.draw do
  authenticated :user do
    root 'dasboard#index'
  end
  unauthenticated :user do
  	devise_scope :user do
  		root 'dasboard#dasboard', as: :unregistered_root
  	end
  end
  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
