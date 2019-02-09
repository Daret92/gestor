# == Schema Information
#
# Table name: permissions
#
#  id         :integer          not null, primary key
#  title      :string
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Permission < ApplicationRecord
  belongs_to :rol, optional: true
end
