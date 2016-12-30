class CurrenciesController < ApplicationController
  layout 'admin'
  before_filter :require_admin
  before_filter :find_currency, :only => [:edit, :update, :destroy]

  def index
    @currencies = Currency.all || [Currency.default]
  end

  def new
    @currency = Currency.new
  end

  def create
    @currency = Currency.new(currency_params)
    if @currency.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to currencies_path
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @currency.update_attributes(currency_params)
      flash[:notice] = l(:notice_successful_update)
      redirect_to currencies_path(:page => params[:page])
    else
      render :action => 'edit'
    end
  end

  def destroy
    @currency.destroy
    redirect_to currencies_path
  rescue
    flash[:error] = l(:"currency.error_unable_delete_currency")
    redirect_to currencies_path
  end

  private
  def find_currency
    if params[:id].present?
      @currency = Currency.find(params[:id])
    else
      false
    end
  end

  def currency_params
    params.require(:currency).permit(:name, :symbol, :decimal_separator, :thousands_separator, :exchange)
  end
end