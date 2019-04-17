# == Schema Information
#
# Table name: materials
#
#  id           :integer          not null, primary key
#  cantidad     :string
#  material     :string
#  descripcion  :string
#  autorizado   :boolean          default(TRUE)
#  entregado    :boolean
#  solicitud_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class MaterialTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
