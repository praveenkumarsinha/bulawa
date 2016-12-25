class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.references :account
      t.string :email
      t.string :name
      t.string :last_login_from
      t.datetime :last_login_at
      t.string :password_digest
      t.timestamps
    end
  end
end
