Rails.application.routes.draw do
  resources 'coffee_points', only: :index
end
