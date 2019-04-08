# == Schema Information
#
# Table name: solicituds
#
#  id                :integer          not null, primary key
#  proyecto_id       :integer
#  estado            :string
#  observaciones     :string
#  user_id           :integer
#  material_id       :integer
#  viatico_id        :integer
#  vehiculo_id       :integer
#  otro_id           :integer
#  solicitud_user_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class SolicitudTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
