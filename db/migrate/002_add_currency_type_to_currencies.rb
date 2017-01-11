class AddCurrencyTypeToCurrencies < ActiveRecord::Migration
  def self.up
    add_column :currencies, :currency_type, :string, :default => 'dinamic', :null => false
  end

  def self.down
    remove_column :currencies, :currency_type
  end
end
