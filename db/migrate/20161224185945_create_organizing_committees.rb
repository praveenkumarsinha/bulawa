class CreateOrganizingCommittees < ActiveRecord::Migration[5.0]
  def change
    create_table :organizing_committees do |t|
      t.references :event
      t.references :entity
      t.string :kind
      t.timestamps
    end
  end
end
