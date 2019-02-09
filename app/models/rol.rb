# == Schema Information
#
# Table name: rols
#
#  id            :integer          not null, primary key
#  nombre        :string
#  descripcion   :string
#  permission_id :integer
#  activo        :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Rol < ApplicationRecord

	has_many :permissions, dependent: :destroy
	accepts_nested_attributes_for :permissions, allow_destroy: true, reject_if: lambda {|attributes| attributes['title'].blank?}
	#accepts_nested_attributes_for :permissions
end
