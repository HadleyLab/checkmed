class FrontendController < ApplicationController

  protected

  def seo
    @seo_carrier ||= nil
    @seo ||= Seo::Basic.new @seo_carrier,
                            false,
                            Rails.application.config.app_humanized_name
  end

  helper_method :seo
end
