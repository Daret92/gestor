class CreateVehiculos < ActiveRecord::Migration[5.2]
  def change
    create_table :vehiculos do |t|
      t.references :solicitud
      t.string :vehiculo
      t.string :descripcion
      t.boolean :devuelto

      t.timestamps
    end
  end
end
