class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :category_id
      t.string :display_name
      t.string :generic_name
      t.string :status, default: "packed"
      t.bigint :user_id, null: false  # user_idカラムを追加

      t.timestamps
    end

    add_foreign_key :items, :categories, column: :category_id
    add_foreign_key :items, :users, column: :user_id  # usersテーブルへの外部キー制約を追加
  end
end
