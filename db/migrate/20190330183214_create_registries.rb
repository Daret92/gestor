class CreateRegistries < ActiveRecord::Migration[5.2]
  def change
    create_table :registries do |t|
      t.references :proyecto, foreign_key: true
      t.references :user, foreign_key: true
      t.string :titulo
      t.string :descripcion
      t.string :resultado
      t.boolean :finalizado

      t.timestamps
    end
  end
end
