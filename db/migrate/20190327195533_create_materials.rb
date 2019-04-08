class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :cantidad
      t.string :material
      t.string :descripcion
      t.boolean :autorizado, default: true
      t.boolean :entregado
      t.references :solicitud

      t.timestamps
    end
  end
end
