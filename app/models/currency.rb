class Currency < ActiveRecord::Base
	has_many :currency_exchange_rate, dependent: :destroy
	after_save :fill_years_with_ones
	#DEFAULT_CURRENCY = Currency.new({:symbol => '€', :decimal_separator => ',', :thousands_separator => '.', :exchange => 1.0})
	#CURRENCY_TYPES = ['dinamic', 'static']

	def self.default_currency
		begin
			User.current.pref[:currency].present? ? Currency.find(User.current.pref[:currency]) : Currency.first
		rescue
			Currency.first.present? ? Currency.first : DEFAULT_CURRENCY
		end
	end

	def fill_years_with_ones (currency_id = self.id)
		unless CurrencyExchangeRate.exists?(currency_id: currency_id)
			cery = CurrencyExchangeRate.select(:year).distinct
			data = []
		    cery.each do |e|
		      element = {}
		      element[:year] = e.year
		      element[:currency_id] = currency_id
		      element[:exchange] = CurrencyExchangeRate::DEFAULT_YEARLY_EXCHANGE
		      data << element
		    end
		    CurrencyExchangeRate.create(data)
		end
		true
	end
end