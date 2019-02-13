# == Schema Information
#
# Table name: equipos
#
#  id                :integer          not null, primary key
#  equipo_usuario_id :integer
#  nombre            :string
#  activo            :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Equipo < ApplicationRecord
  has_many :equipo_usuario, dependent: :destroy
  accepts_nested_attributes_for :equipo_usuario, allow_destroy: true, reject_if: lambda {|attributes| attributes['user_id'].blank?}
end
