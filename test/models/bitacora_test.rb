# == Schema Information
#
# Table name: bitacoras
#
#  id          :integer          not null, primary key
#  proyecto_id :integer
#  user_id     :integer
#  nota        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class BitacoraTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
