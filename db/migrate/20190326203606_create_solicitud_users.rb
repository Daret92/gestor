class CreateSolicitudUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :solicitud_users do |t|
      t.references :solicitud
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
