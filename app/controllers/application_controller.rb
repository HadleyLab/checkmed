class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # # HTTP basic authentication
  # if %w(production staging).include?(Rails.env)
  #   http_basic_authenticate_with name: "modern", password: "talking"
  # end

  protected

  def setting_value(setting_name)
    case setting_name
    when :app_humanized_name
      Rails.application.config.app_humanized_name
    else
      SettingProvider.instance.value_of setting_name
    end
  end

  helper_method :setting_value
end
