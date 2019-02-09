class CreateRols < ActiveRecord::Migration[5.2]
  def change
    create_table :rols do |t|
      t.string :nombre
      t.string :descripcion
      t.references :permission, foreign_key: true
      t.boolean :activo
      
      t.timestamps
    end
  end
end
