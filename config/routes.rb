Rails.application.routes.draw do
  resources :learners

  resources :tokens do
    post :refresh, on: :collection
  end

  resources :pieces do
    post :duplicate
  end
end
