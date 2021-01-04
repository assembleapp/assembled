Rails.application.routes.draw do
    get "/graphics", to: "graphics#index"
    root to: "pages#index"
end
