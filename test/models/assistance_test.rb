# == Schema Information
#
# Table name: assistances
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  latitud    :string
#  longitud   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AssistanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
