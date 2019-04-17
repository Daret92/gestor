# == Schema Information
#
# Table name: cvehiculos
#
#  id          :integer          not null, primary key
#  titulo      :string
#  descripcion :string
#  activo      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cvehiculo < ApplicationRecord
end
