class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.string :title
      t.boolean :active
      t.references :rol
      t.timestamps
    end
  end
end
