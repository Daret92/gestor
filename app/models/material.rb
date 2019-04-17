# == Schema Information
#
# Table name: materials
#
#  id           :integer          not null, primary key
#  cantidad     :string
#  material     :string
#  descripcion  :string
#  autorizado   :boolean          default(TRUE)
#  entregado    :boolean
#  solicitud_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Material < ApplicationRecord
  belongs_to :solicitud, optional: true
end
