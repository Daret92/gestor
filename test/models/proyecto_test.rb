# == Schema Information
#
# Table name: proyectos
#
#  id          :integer          not null, primary key
#  titulo      :string
#  estado      :string
#  inicio      :date
#  fin         :date
#  descripcion :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ProyectoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
