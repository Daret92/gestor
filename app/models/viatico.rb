# == Schema Information
#
# Table name: viaticos
#
#  id           :integer          not null, primary key
#  cantidad     :string
#  descripcion  :string
#  autorizada   :boolean          default(TRUE)
#  entrega      :boolean
#  solicitud_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Viatico < ApplicationRecord
  belongs_to :solicitud, optional: true
end
