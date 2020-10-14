require "application_system_test_case"

class FormExciseTaxesTest < ApplicationSystemTestCase
  setup do
    @form_excise_tax = form_excise_taxes(:one)
  end

  test "visiting the index" do
    visit form_excise_taxes_url
    assert_selector "h1", text: "Form Excise Taxes"
  end

  test "creating a Form excise tax" do
    visit form_excise_taxes_url
    click_on "New Form Excise Tax"

    fill_in "Cusname", with: @form_excise_tax.cusname
    fill_in "Formdata", with: @form_excise_tax.formdata
    fill_in "Formeffectivedate", with: @form_excise_tax.formeffectivedate
    fill_in "Formreferencenumber", with: @form_excise_tax.formreferencenumber
    fill_in "Signflag", with: @form_excise_tax.signflag
    click_on "Create Form excise tax"

    assert_text "Form excise tax was successfully created"
    click_on "Back"
  end

  test "updating a Form excise tax" do
    visit form_excise_taxes_url
    click_on "Edit", match: :first

    fill_in "Cusname", with: @form_excise_tax.cusname
    fill_in "Formdata", with: @form_excise_tax.formdata
    fill_in "Formeffectivedate", with: @form_excise_tax.formeffectivedate
    fill_in "Formreferencenumber", with: @form_excise_tax.formreferencenumber
    fill_in "Signflag", with: @form_excise_tax.signflag
    click_on "Update Form excise tax"

    assert_text "Form excise tax was successfully updated"
    click_on "Back"
  end

  test "destroying a Form excise tax" do
    visit form_excise_taxes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Form excise tax was successfully destroyed"
  end
end
