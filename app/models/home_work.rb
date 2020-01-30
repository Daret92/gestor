# == Schema Information
#
# Table name: home_works
#
#  id          :integer          not null, primary key
#  proyecto_id :integer
#  user_id     :integer
#  user2_id    :integer
#  descripcion :string
#  urgente     :string
#  limite      :string
#  finalizado  :boolean
#  resultado   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class HomeWork < ApplicationRecord
  belongs_to :proyecto
  belongs_to :user, class_name: "User"
  belongs_to :user2, class_name: "User"
end
