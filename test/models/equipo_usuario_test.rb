# == Schema Information
#
# Table name: equipo_usuarios
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  activo     :boolean
#  equipo_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class EquipoUsuarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
