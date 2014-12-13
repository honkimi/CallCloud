Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :tels do
    resource :sheets
    resources :twilio_phones
    resources :records
    resources :members
  end
  resources :invites

  get 'twilio/:tel_id/welcome' => 'twilio#welcome', as: :welcome
  get 'twilio/:tel_id/action' => 'twilio#action', as: :action
  get 'twilio/:tel_id/action2/:action_id' => 'twilio#action2', as: :action2

end
