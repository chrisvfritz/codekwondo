Rails.application.routes.draw do

  root to: 'home#index'

  # --------------
  # AUTHENTICATION
  # --------------

  match  '/auth/github/callback'        => 'sessions#create', via: [:get, :post]
  delete '/signout'                     => 'sessions#destroy', as: :signout
  get    '/auth/failure'                => 'sessions#failure'

  match  '/auth/stackexchange/callback' => 'users#connect_stackoverflow', via: [:get, :post]

  resources :resources, only: [:new, :create] do
    collection { get :bookmarklet }
  end

  resources :courses, shallow: true do
    collection { post :sort }

    resources :skills, shallow: true, except: [:index] do
      collection { post :sort }

      member { get :presentation }

      resources :resources, except: [:index, :show] do
        member do
          put 'like',    to: 'resources#upvote'
          put 'dislike', to: 'resources#downvote'
        end
      end

      resources :projects, shallow: true, except: [:index] do
        resources :project_completions, path: '/showcases', except: [:index] do
          member { get :screenshot }
          member { put :approve }
        end
      end
    end
  end

  resources :project_completions, path: '/showcases', only: [:index]

  get 'users/profile', as: :user_profile

  get 'stackoverflow/tags', as: :stackoverflow_tags

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
