Redmine::Plugin.register :redmine_currency do
  Rails.configuration.after_initialize do
    locale = if Setting.table_exists?
               Setting.default_language
             else
               'en'
             end
    I18n.with_locale(locale) do
      name I18n.t :'currency.plugin_name'
      description I18n.t :'currency.plugin_description'
      author 'Emergya Consultoría'
      version '0.0.1'
    end
  end

  settings :default => {}, :partial => 'settings/currency_settings'

  # project_module :bscplugin do
  #   permission :bsc_management, { :bsc_management => [:index] }
  #   permission :bsc_checkpoints, { :bsc_checkpoints => [:index, :new, :show, :edit, :destroy, :update, :create] }
  #   permission :bsc_metrics, { :bsc_metrics => [:index, :change_metric] }
  # end

  menu :admin_menu, :currencymenu, { :controller => 'currencies', :action => 'index' }, :html => { :class => 'currency' }, :caption => :"currency.label_currency"
end
