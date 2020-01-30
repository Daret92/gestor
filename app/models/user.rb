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
#  token_msj              :string
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,:recoverable, :rememberable
  has_one_attached :avatar
  belongs_to :rol, optional: true
  has_many :home_work, :class_name => "User", :foreign_key => "user_id"
  has_many :home_work, :class_name => "User", :foreign_key => "user2_id"
end
