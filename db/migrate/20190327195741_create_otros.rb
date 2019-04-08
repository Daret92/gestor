class CreateOtros < ActiveRecord::Migration[5.2]
  def change
    create_table :otros do |t|
      t.references :solicitud
      t.string :descripcion
      t.boolean :finalizada

      t.timestamps
    end
  end
end
