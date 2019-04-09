class CreateCvehiculos < ActiveRecord::Migration[5.2]
  def change
    create_table :cvehiculos do |t|
      t.string :titulo
      t.string :descripcion
      t.boolean :activo

      t.timestamps
    end
  end
end
