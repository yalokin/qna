Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'questions#index'

  concern :votable do
    patch :vote_up, on: :member
    patch :vote_down, on: :member
  end

  resources :questions do
    resources :answers, shallow: true do
      patch :best, on: :member
      concerns :votable
    end
  end

  resources :attachments, only: [:destroy]
end
