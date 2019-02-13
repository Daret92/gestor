class CreateEquipos < ActiveRecord::Migration[5.2]
  def change
    create_table :equipos do |t|
      t.references :equipo_usuario, foreign_key: true
      t.references :user, foreign_key: true
      t.string :nombre
      t.boolean :activo

      t.timestamps
    end
  end
end
