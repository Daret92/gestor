class CreateViaticos < ActiveRecord::Migration[5.2]
  def change
    create_table :viaticos do |t|
      t.string :cantidad
      t.string :descripcion
      t.boolean :autorizada, default: true
      t.boolean :entrega
      t.references :solicitud

      t.timestamps
    end
  end
end
