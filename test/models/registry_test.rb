# == Schema Information
#
# Table name: registries
#
#  id          :integer          not null, primary key
#  proyecto_id :integer
#  user_id     :integer
#  titulo      :string
#  descripcion :string
#  resultado   :string
#  finalizado  :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class RegistryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
