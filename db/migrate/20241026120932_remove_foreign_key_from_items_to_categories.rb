class RemoveForeignKeyFromItemsToCategories < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :items, :categories, if_exists: true
  end
end
