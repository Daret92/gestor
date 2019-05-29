class CreateAssistances < ActiveRecord::Migration[5.2]
  def change
    create_table :assistances do |t|
      t.references :user, foreign_key: true
      t.string :latitud
      t.string :longitud

      t.timestamps
    end
  end
end
