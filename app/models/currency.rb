class Currency < ActiveRecord::Base
	DEFAULT_CURRENCY = Currency.new({:symbol => '€', :decimal_separator => ',', :thousands_separator => '.', :exchange => 1.0})

	def self.default_currency
		Currency.first || DEFAULT_CURRENCY
	end
end