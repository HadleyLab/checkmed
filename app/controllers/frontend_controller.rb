class FrontendController < ApplicationController

  protected

  def seo
    @seo_carrier ||= nil
    @seo ||= Seo::Basic.new @seo_carrier, false, setting_value('site_name')
  end

  def setting_value(setting_name)
    case setting_name
    when :app_humanized_name
      Rails.application.config.app_humanized_name
    else
      nil
    end
  end

  helper_method :setting_value, :seo
end
