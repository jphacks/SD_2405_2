class Item < ApplicationRecord
    belongs_to :user  # Userモデルとの関連付け
    belongs_to :category  # Categoryモデルとの関連付け
  
    validates :display_name, presence: true
    validates :status, inclusion: { in: ['packed', 'unpacked', 'used'] }  # statusのバリデーション
end