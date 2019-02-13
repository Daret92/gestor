# == Schema Information
#
# Table name: equipo_usuarios
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  activo     :boolean
#  equipo_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EquipoUsuario < ApplicationRecord
  belongs_to :user
  belongs_to :equipo, optional: true
end
