CanvasApi::Application.routes.draw do
  root to: 'courses#index'
  resources :courses, :only => [:index, :show] do
    resources :enrollments, :only => [:index, :create]
  end
end
