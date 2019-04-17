class CreateGpsSaves < ActiveRecord::Migration[5.2]
  def change
    create_table :gps_saves do |t|
      t.references :user, foreign_key: true
      t.references :proyecto, foreign_key: true
      t.string :latitud
      t.string :longitud

      t.timestamps
    end
  end
end
