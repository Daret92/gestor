class CreateBitacoras < ActiveRecord::Migration[5.2]
  def change
    create_table :bitacoras do |t|
      t.references :proyecto, foreign_key: true
      t.references :user, foreign_key: true
      t.string :nota

      t.timestamps
    end
  end
end
