class AddExpiryDateToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :expiry_date, :date
  end
end
