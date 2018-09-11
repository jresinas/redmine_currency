class CurrencyExchangeRatesController < ApplicationController
  layout 'admin'
  before_filter :find_currencies, :only => [:index, :edit_year, :update_year]
  before_filter :require_admin
  

  def index
    @year_exchange_rates = CurrencyExchangeRate.includes(:currency).where("currency_id IN (?)", @currencies.map(&:id)).group_by(&:year)

    if @year_exchange_rates.present?
      @years = @year_exchange_rates.keys.sort.reverse
      @next_year = @years.first+1
      @year_options = ((@years.last-5)..(@next_year+5))
    else
      @years = []
      @next_year = Date.today.year
      @year_options = ((@next_year-5)..(@next_year+5))
    end
  end 

  def edit_year
    @year = params[:year]
    @exchange_rates = CurrencyExchangeRate.includes(:currency).where(year: @year)

    respond_to do |format|
      format.js
    end
  end

  def update_year
    @year = params[:year]
    @exchange_rates = CurrencyExchangeRate.includes(:currency).where(year: @year)
    @message = ""

    CurrencyExchangeRate.transaction do
      errors = CurrencyExchangeRate.update(params[:currency_exchange_rate].keys, params[:currency_exchange_rate].values).map(&:get_errors).flatten

      if errors.present?
        @flash = 'error'
        @message = errors.join('<br>').html_safe
        raise ActiveRecord::Rollback, @message
      else
        @flash = 'notice'
        @message = l(:notice_successful_update)
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def create_year
    data = []

    params[:values].each do |k,v|
      element = {}
      element[:year] = params[:year]
      element[:currency_id] = k
      element[:exchange] = v.present? ? v : CurrencyExchangeRate::DEFAULT_YEARLY_EXCHANGE
      data << element
    end

    CurrencyExchangeRate.transaction do
      errors = CurrencyExchangeRate.create(data).map(&:get_errors).flatten

      if errors.present?
        message = errors.join('<br>').html_safe
        flash['error'] = message
        raise ActiveRecord::Rollback, message
      else
        flash['notice'] = l(:notice_successful_create)
      end
    end

    redirect_to :action => 'index'
  end

  def destroy_year
    CurrencyExchangeRate.transaction do
      errors = CurrencyExchangeRate.destroy_all(year: params[:year]).map(&:get_errors).flatten

      if errors.present? or CurrencyExchangeRate.where(year: params[:year]).present?
        message = errors.present? ? errors.join('<br>').html_safe : l(:"currency.error_unable_destroy")
        flash['error'] = message
        raise ActiveRecord::Rollback, message
      else
        flash['notice']= l(:notice_successful_delete)
      end
    end
    
    redirect_to :action => 'index'
  end

  private
  def find_currencies
    @currencies = Currency.all.order(:id)
  end
end