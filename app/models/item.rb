class Item < ApplicationRecord
    belongs_to :user  # Userモデルとの関連付け
    has_many :item_categories
    has_many :categories, through: :item_categories
  
    validates :display_name, presence: true
    validates :status, inclusion: { in: ['packed', 'unpacked', 'used'] }  # statusのバリデーション
end