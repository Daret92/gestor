# == Schema Information
#
# Table name: otros
#
#  id           :integer          not null, primary key
#  solicitud_id :integer
#  descripcion  :string
#  finalizada   :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Otro < ApplicationRecord
  belongs_to :solicitud, optional: true
end
