# == Schema Information
#
# Table name: gps_saves
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  proyecto_id :integer
#  latitud     :string
#  longitud    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class GpsSave < ApplicationRecord
  belongs_to :user
  belongs_to :proyecto
end
