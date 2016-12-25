class CreateCommunicationKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :communication_keys do |t|
      t.references :app
      t.integer :generator_id
      t.string :access_token
      t.integer :use_counter
      t.datetime :used_at
      t.timestamps
    end
  end
end
