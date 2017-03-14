class ChecklistsController < FrontendController
  before_action :authenticate_user!, except: :show

  def show
    @checklist = Checklist.find params[:id]
    @user = @checklist.user
    # TODO @seo_carrier
    respond_to do |format|
      format.html
    end
  end

  def new
    @checklist = Checklist.new
    # TODO @seo_carrier
    respond_to do |format|
      format.html
    end
  end

  def edit
    @checklist = Checklist.find(params[:id])
    # TODO @seo_carrier
    respond_to do |format|
      format.html
    end
  end

  def create
    @checklist = Checklist.new(checklist_params)
    @checklist.user = current_user

    if @checklist.save
      redirect_to @checklist
    else
      render 'new'
    end
  end

  def update
    @checklist = Checklist.find(params[:id])

    if @checklist.update(checklist_params)
      redirect_to @checklist
    else
      render 'edit'
    end
  end

  def destroy
    @checklist = Checklist.find(params[:id])
    @checklist.destroy

    redirect_to checklists_path
  end

  private
    def checklist_params
      params.require(:checklist).permit(
          :name,
          :executor_role_id,
          :treat_stage,
          :descr,
          :prior,
          :hided
        )
    end
end
