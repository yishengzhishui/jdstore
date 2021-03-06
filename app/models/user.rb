# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default("f")
#  avatar                 :string
#  username               :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end
  mount_uploader :avatar, ImageUploader
  validates :username, presence: true
  has_many :orders

  has_many :reviews
#--------收藏------
  has_many :product_user_relationships
  has_many :participated_products, :through => :product_user_relationships, :source => :product

  def is_member_of?(product)
    participated_products.include?(product)
  end

  def join!(product)
    participated_products << product
  end

  def quit!(product)
    participated_products.delete(product)
  end


end
