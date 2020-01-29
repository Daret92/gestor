# == Schema Information
#
# Table name: home_works
#
#  id          :integer          not null, primary key
#  proyecto_id :integer
#  user_id     :integer
#  descripcion :string
#  urgente     :string
#  limite      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class HomeWork < ApplicationRecord
  belongs_to :proyecto
  belongs_to :user
end
