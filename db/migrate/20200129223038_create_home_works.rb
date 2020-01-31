class CreateHomeWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :home_works do |t|
      t.references :proyecto, foreign_key: true
      t.references :usuario, foreign_key: { to_table: 'users' }
      t.references :administrador, foreign_key: { to_table: 'users' }
      t.string :descripcion
      t.boolean :urgente
      t.string :limite
      t.boolean :finalizado
      t.string :resultado


      t.timestamps
    end
  end
end
