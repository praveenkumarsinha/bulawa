class CreateDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :details do |t|
      t.references :detailable, polymorphic: true, index: true
      t.string :property_key_stripped
      t.string :property_key
      t.string :property_value
      t.timestamps
    end
  end
end
