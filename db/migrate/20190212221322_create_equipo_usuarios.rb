class CreateEquipoUsuarios < ActiveRecord::Migration[5.2]
  def change
    create_table :equipo_usuarios do |t|
      t.references :user, foreign_key: true
      t.boolean :activo
      t.references :equipo

      t.timestamps
    end
  end
end
