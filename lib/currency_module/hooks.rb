module CurrencyModule
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_my_account_preferences,
              :partial => 'hooks/currency_module/currency_preferences'
    render_on :view_users_form_preferences,
              :partial => 'hooks/currency_module/currency_preferences'
  end
end