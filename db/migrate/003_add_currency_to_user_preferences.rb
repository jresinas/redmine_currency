class AddCurrencyToUserPreferences < ActiveRecord::Migration
  def self.up
    add_column :user_preferences, :currency, :integer, :null => true
  end

  def self.down
    remove_column :user_preferences, :currency
  end
end
