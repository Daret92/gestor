class CreateHomeWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :home_works do |t|
      t.references :proyecto, foreign_key: true
      t.references :user, foreign_key: { to_table: 'User' }
      t.references :user2, foreign_key: { to_table: 'User' }
      t.string :descripcion
      t.string :urgente
      t.string :limite
      t.boolean :finalizado
      t.string :resultado


      t.timestamps
    end
  end
end
