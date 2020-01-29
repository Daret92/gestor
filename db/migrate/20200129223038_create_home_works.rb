class CreateHomeWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :home_works do |t|
      t.references :proyecto, foreign_key: true
      t.references :user, foreign_key: true
      t.string :descripcion
      t.string :urgente
      t.string :limite

      t.timestamps
    end
  end
end
