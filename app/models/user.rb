class User < ApplicationRecord
  belongs_to :subsidiary
  has_many :rentals, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum status: { employee: 0, admin: 5 }
end
