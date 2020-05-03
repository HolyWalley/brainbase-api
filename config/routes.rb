Rails.application.routes.draw do
  resources :learners

  resources :tokens do
    post :refresh, on: :collection
  end

  resources :pieces do
    delete "disconnect/:parent_id", action: :disconnect

    post :duplicate
  end

  resources :pieces_connections
end
