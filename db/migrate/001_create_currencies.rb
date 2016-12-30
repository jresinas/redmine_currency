class CreateCurrencies < ActiveRecord::Migration
  def self.up
	create_table :currencies do |t|
      t.string :name, :null => false
      t.string :symbol, :null => false
      t.string :decimal_separator, :limit => 1, :default => ''
      t.string :thousands_separator, :limit => 1, :default => ''
      t.decimal :exchange, :precision => 20, :scale => 10, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :currencies
  end
end
