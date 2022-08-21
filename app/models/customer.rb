class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :kana_lastname, presence: true
  validates :kana_firstname, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :tel, presence: true
  validates :email, presence: true

end
