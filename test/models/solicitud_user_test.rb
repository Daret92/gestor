# == Schema Information
#
# Table name: solicitud_users
#
#  id           :integer          not null, primary key
#  solicitud_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class SolicitudUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
