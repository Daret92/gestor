class CreateSolicituds < ActiveRecord::Migration[5.2]
  def change
    create_table :solicituds do |t|
      t.references :proyecto, foreign_key: true
      t.string :estado
      t.string :observaciones
      t.references :user, foreign_key: true
      t.references :material, foreign_key: true
      t.references :viatico, foreign_key: true
      t.references :vehiculo, foreign_key: true
      t.references :otro, foreign_key: true
      t.references :solicitud_user, foreign_key: true

      t.timestamps
    end
  end
end
