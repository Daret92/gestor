# == Schema Information
#
# Table name: viaticos
#
#  id           :integer          not null, primary key
#  cantidad     :string
#  descripcion  :string
#  autorizada   :boolean          default(TRUE)
#  entrega      :boolean
#  solicitud_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class ViaticoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
