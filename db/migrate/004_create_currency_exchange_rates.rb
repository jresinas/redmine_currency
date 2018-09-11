class CreateCurrencyExchangeRates < ActiveRecord::Migration
  def self.up
    create_table :currency_exchange_rates, :force => true do |t|
      t.column :currency_id, :integer, :null => true
      t.column :year, :integer, :null => false
      t.column :exchange, :float, :default => 0.0, :null => false
    end
    remove_column :currencies, :currency_type
    remove_column :currencies, :exchange
  end

  def self.down
    add_column :currencies, :exchange, :precision => 20, :scale => 10, :null => false
    add_column :currencies, :currency_type, :string, :default => 'dinamic', :null => false
    drop_table :currency_exchange_rates
  end
end