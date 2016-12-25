class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :app
      t.string :name
      t.timestamps
    end
  end
end
