class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
      t.references :account
      t.string :name
      t.string :environment
      t.timestamps
    end
  end
end
