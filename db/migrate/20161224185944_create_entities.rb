class CreateEntities < ActiveRecord::Migration[5.0]
  def change
    create_table :entities do |t|
      t.references :app
      t.string :name
      t.timestamps
    end
  end
end
