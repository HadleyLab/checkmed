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

  def top
    @checklists = Checklist.visibles.best.take(10)
    @seo_carrier = OpenStruct.new({
                                      title: 'Most liked checklists',
                                      seo_descr: 'Most liked checklists'
                                  })
  end

end
