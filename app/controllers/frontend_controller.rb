class FrontendController < ApplicationController

  protected

  def determine_page
    @page = nil
    # try to find page for current url
    if path_match = request.fullpath.match(/^\/?([^\?]*)\??/)
      @page = Page.find_by_path path_match[1]
    end
    @seo_carrier = @page
  end

  def seo
    @seo_carrier ||= nil
    @seo ||= Seo::Basic.new @seo_carrier,
                            false,
                            Rails.application.config.app_humanized_name
  end

  helper_method :seo
end
