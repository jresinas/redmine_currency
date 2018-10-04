class CurrencyExchangeRate < ActiveRecord::Base
	
	belongs_to :currency, class_name: "Currency", foreign_key: "currency_id"

	validates :exchange, :numericality => { :greater_than_or_equal_to => 0 }, :presence => true

	DEFAULT_YEARLY_EXCHANGE = 1.0

	def self.years
		select(:year).distinct.map(&:year)
	end

	def get_errors
		errors.present? ? errors.full_messages.map{|m| profile.name+": "+m} : []
	end
end
