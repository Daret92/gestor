class CreateNotificacions < ActiveRecord::Migration[5.2]
  def change
    create_table :notificacions do |t|
      t.references :user, foreign_key: true
      t.references :solicitud, foreign_key: true
      t.string :texto
      t.boolean :leido
      t.string :tipo

      t.timestamps
    end
  end
end
