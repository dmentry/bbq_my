class Event < ApplicationRecord
  #событие всегда принадлежит юзеру
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos, dependent: :destroy

  #Должен быть юзер
  validates :user, presence: true

  validates :title, presence: true, length: {maximum: 255}
  validates :address, presence: true
  validates :datetime, presence: true

  def visitors
    (subscribers + [user]).uniq
  end

  # совпадает ли введенный параметр с пинкодом этого события
  def pincode_valid?(pin2chek)
    pincode == pin2chek
  end
end
