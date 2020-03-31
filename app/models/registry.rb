# == Schema Information
#
# Table name: registries
#
#  id          :integer          not null, primary key
#  proyecto_id :integer
#  user_id     :integer
#  titulo      :string
#  descripcion :string
#  resultado   :string
#  finalizado  :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Registry < ApplicationRecord
  belongs_to :proyecto
  belongs_to :user
  validates :titulo, presence: true
  validates :descripcion, presence: true
  validates :resultado, presence: true
  has_one_attached :evidencia
end
