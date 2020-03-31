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

class Bitacora < ApplicationRecord
  belongs_to :proyecto
  belongs_to :user
  #has_one_attached :evidencia
end
