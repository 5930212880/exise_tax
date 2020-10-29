# == Schema Information
#
# Table name: form_excise_taxes
#
#  id                  :bigint           not null, primary key
#  cusname             :string
#  formdata            :jsonb
#  formeffectivedate   :date
#  formreferencenumber :string
#  signflag            :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_form_excise_taxes_on_formreferencenumber  (formreferencenumber)
#
class FormExciseTax < ApplicationRecord
    validates :formreferencenumber, presence: true
    validates :formeffectivedate, presence: true
end
