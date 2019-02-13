# == Schema Information
#
# Table name: equipos
#
#  id                :integer          not null, primary key
#  equipo_usuario_id :integer
#  user_id           :integer
#  nombre            :string
#  activo            :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class EquipoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
