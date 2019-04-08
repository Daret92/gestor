# == Schema Information
#
# Table name: solicituds
#
#  id                :integer          not null, primary key
#  proyecto_id       :integer
#  estado            :string
#  observaciones     :string
#  user_id           :integer
#  material_id       :integer
#  viatico_id        :integer
#  vehiculo_id       :integer
#  otro_id           :integer
#  solicitud_user_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Solicitud < ApplicationRecord
  belongs_to :proyecto, optional: true
  belongs_to :user, optional: true
  validates :observaciones, presence: true

  has_many :materials, dependent: :destroy
  accepts_nested_attributes_for :materials, allow_destroy: true, reject_if: lambda {|attributes| attributes['cantidad'].blank?}

  has_many :viaticos, dependent: :destroy
  accepts_nested_attributes_for :viaticos, allow_destroy: true, reject_if: lambda {|attributes| attributes['cantidad'].blank?}

  has_many :vehiculos, dependent: :destroy
  accepts_nested_attributes_for :vehiculos, allow_destroy: true, reject_if: lambda {|attributes| attributes['vehiculo'].blank?}

  has_many :otro, dependent: :destroy
  accepts_nested_attributes_for :otro, allow_destroy: true, reject_if: lambda {|attributes| attributes['descripcion'].blank?}

  has_many :solicitud_users, dependent: :destroy
  accepts_nested_attributes_for :solicitud_users, allow_destroy: true, reject_if: lambda {|attributes| attributes['user_id'].blank?}
end
