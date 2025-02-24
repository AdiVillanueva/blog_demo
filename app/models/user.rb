class User < ApplicationRecord
  has_many :posts, dependent: :destroy


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  audited except: %i[encrypted_password]
  has_associated_audits
end
