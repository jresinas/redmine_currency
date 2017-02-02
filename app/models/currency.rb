class Currency < ActiveRecord::Base
	DEFAULT_CURRENCY = Currency.new({:symbol => '€', :decimal_separator => ',', :thousands_separator => '.', :exchange => 1.0})
	CURRENCY_TYPES = ['dinamic', 'static']

	def self.default_currency
		begin
			User.current.pref[:currency].present? ? Currency.find(User.current.pref[:currency]) : Currency.first
		rescue
			Currency.first.present? ? Currency.first : DEFAULT_CURRENCY
		end
	end
end