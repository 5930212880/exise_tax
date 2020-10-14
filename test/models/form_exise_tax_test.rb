# == Schema Information
#
# Table name: form_exise_taxes
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
#  index_form_exise_taxes_on_formreferencenumber  (formreferencenumber) UNIQUE
#
require 'test_helper'

class FormExiseTaxTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
