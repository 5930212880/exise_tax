require 'test_helper'

class FormExciseTaxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form_excise_tax = form_excise_taxes(:one)
  end

  test "should get index" do
    get form_excise_taxes_url
    assert_response :success
  end

  test "should get new" do
    get new_form_excise_tax_url
    assert_response :success
  end

  test "should create form_excise_tax" do
    assert_difference('FormExciseTax.count') do
      post form_excise_taxes_url, params: { form_excise_tax: { cusname: @form_excise_tax.cusname, formdata: @form_excise_tax.formdata, formeffectivedate: @form_excise_tax.formeffectivedate, formreferencenumber: @form_excise_tax.formreferencenumber, signflag: @form_excise_tax.signflag } }
    end

    assert_redirected_to form_excise_tax_url(FormExciseTax.last)
  end

  test "should show form_excise_tax" do
    get form_excise_tax_url(@form_excise_tax)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_excise_tax_url(@form_excise_tax)
    assert_response :success
  end

  test "should update form_excise_tax" do
    patch form_excise_tax_url(@form_excise_tax), params: { form_excise_tax: { cusname: @form_excise_tax.cusname, formdata: @form_excise_tax.formdata, formeffectivedate: @form_excise_tax.formeffectivedate, formreferencenumber: @form_excise_tax.formreferencenumber, signflag: @form_excise_tax.signflag } }
    assert_redirected_to form_excise_tax_url(@form_excise_tax)
  end

  test "should destroy form_excise_tax" do
    assert_difference('FormExciseTax.count', -1) do
      delete form_excise_tax_url(@form_excise_tax)
    end

    assert_redirected_to form_excise_taxes_url
  end
end
