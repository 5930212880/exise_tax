class CreateFormExciseTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :form_excise_taxes do |t|
      t.string :formreferencenumber
      t.date :formeffectivedate
      t.string :cusname
      t.string :signflag
      t.jsonb :formdata

      t.timestamps
    end
    add_index :form_excise_taxes, :formreferencenumber, unique: true
  end
end
