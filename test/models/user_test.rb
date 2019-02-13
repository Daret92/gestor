# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  rol_id                 :integer
#  users_id               :integer
#  super_user             :boolean          default(FALSE)
#  alias                  :string
#  nombre                 :string
#  apellido               :string
#  auth_token             :string
#  activo                 :boolean
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
