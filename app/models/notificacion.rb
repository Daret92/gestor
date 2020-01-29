# == Schema Information
#
# Table name: notificacions
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  solicitud_id :integer
#  texto        :string
#  leido        :boolean
#  tipo         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Notificacion < ApplicationRecord
  belongs_to :user
  belongs_to :solicitud
end
