class CreateProyectos < ActiveRecord::Migration[5.2]
  def change
    create_table :proyectos do |t|
      t.string :titulo
      t.string :estado
      t.date :inicio
      t.date :fin
      t.string :descripcion
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
