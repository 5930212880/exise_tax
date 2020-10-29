Rails.application.routes.draw do
  get 'inquiry/:formeffectivedate', to: 'form_excise_taxes#inquiry'
  get 'form_excise_taxes', to: 'form_excise_taxes#index'
  get 'excisetax/new', to: 'form_excise_taxes#new'
  # get 'form_excise_taxes/:id', to: 'form_excise_taxes#show' , as: :form_excise_tax
  resources :form_excise_taxes , only: [:show]
  post 'form_excise_taxes', to: 'form_excise_taxes#inquiry'

  post 'form_excise_taxes/saveformproductsource', to: 'form_excise_taxes#save_form_product_source'
  post 'form_excise_taxes/inquirychecklistsou', to: 'form_excise_taxes#inquiry_form_product_checklist_sou'
  post 'form_excise_taxes/inquirychecklistdes', to: 'form_excise_taxes#inquiry_form_product_checklist_des'

  root 'form_excise_taxes#index'
end
