class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  has_many :books, dependent: :destroy
  
  has_one_attached :profile_image

validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
validates :email_address, presence: true, uniqueness: true
validates :password, length: { minimum: 6 }, if: -> { password.present? }
validates :introduction, length: { maximum: 50 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width ,height]).processed
  end
end