class CreateRols < ActiveRecord::Migration[5.2]
  def change
    create_table :rols do |t|
      t.string :nombre
      t.string :descripcion
      t.boolean :activo
      
      t.timestamps
    end
  end
end
