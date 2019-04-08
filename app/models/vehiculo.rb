# == Schema Information
#
# Table name: vehiculos
#
#  id           :integer          not null, primary key
#  solicitud_id :integer
#  vehiculo     :string
#  descripcion  :string
#  devuelto     :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vehiculo < ApplicationRecord
  belongs_to :solicitud, optional: true
end
