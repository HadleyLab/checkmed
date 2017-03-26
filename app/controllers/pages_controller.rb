class PagesController < FrontendController
  def home
    respond_to do |format|
      format.html
    end
  end
end
