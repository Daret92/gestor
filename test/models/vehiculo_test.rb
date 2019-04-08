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

require 'test_helper'

class VehiculoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
