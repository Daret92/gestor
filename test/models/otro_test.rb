# == Schema Information
#
# Table name: otros
#
#  id           :integer          not null, primary key
#  solicitud_id :integer
#  descripcion  :string
#  finalizada   :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class OtroTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
