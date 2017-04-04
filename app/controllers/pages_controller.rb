class PagesController < FrontendController
  def show
    determine_page
    if @page.nil?
      raise ActiveRecord::RecordNotFound, "Record not found"
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def home
    respond_to do |format|
      format.html
    end
  end
end
