# == Schema Information
#
# Table name: rols
#
#  id            :integer          not null, primary key
#  nombre        :string
#  descripcion   :string
#  permission_id :integer
#  activo        :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class RolTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
