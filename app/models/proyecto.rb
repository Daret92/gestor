# == Schema Information
#
# Table name: proyectos
#
#  id          :integer          not null, primary key
#  titulo      :string
#  estado      :string
#  inicio      :date
#  fin         :date
#  descripcion :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Proyecto < ApplicationRecord
  belongs_to :user, optional: true
end
