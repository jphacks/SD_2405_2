class Category < ApplicationRecord
    #has_many :items  # Itemモデルとの関連付け
  
    validates :name, presence: true, uniqueness: true  # nameのバリデーション
  end