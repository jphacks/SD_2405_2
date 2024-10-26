class RemoveCategoryIdFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :category_id, :integer
  end
end
