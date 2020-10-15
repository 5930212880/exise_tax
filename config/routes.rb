Rails.application.routes.draw do
  get 'form_excise_taxes/:formeffectivedate', to: 'form_excise_taxes#inquiry'
  get 'form_excise_taxes', to: 'form_excise_taxes#index'
  # get 'get_data/updatedate', to: 'form_excise_taxes#updatedate'
  get 'form_excise_taxes/new', to: 'form_excise_taxes#new'
  # get 'form_data/:formreferencenumber', to: 'form_data#show'

  post 'form_excise_taxes/saveformproductsource', to: 'form_excise_taxes#save_form_product_source'
  post 'form_excise_taxes/inquirychecklistsou', to: 'form_excise_taxes#inquiry_form_product_checklist_sou'
  post 'form_excise_taxes/inquirychecklistdes', to: 'form_excise_taxes#inquiry_form_product_checklist_des'
end
