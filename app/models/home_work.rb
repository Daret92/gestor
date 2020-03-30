# == Schema Information
#
# Table name: home_works
#
#  id               :integer          not null, primary key
#  proyecto_id      :integer
#  usuario_id       :integer
#  administrador_id :integer
#  descripcion      :string
#  urgente          :string
#  limite           :string
#  finalizado       :boolean
#  resultado        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class HomeWork < ApplicationRecord
  belongs_to :proyecto
  belongs_to :usuario, class_name: "User"
  belongs_to :administrador, class_name: "User"
  has_one_attached :evidencia
end
