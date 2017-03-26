class ChecklistsController < FrontendController
  before_action :authenticate_user!

  def show
    @checklist = Checklist.find params[:id]
    @seo_carrier = OpenStruct.new title: "Checklist: #{@checklist.name}"
    @user = @checklist.user

    # log a visit
    unless current_user == @user
      current_user.checklists_visits.create checklist: @checklist
    end

    respond_to do |format|
      format.html
    end
  end

  def new
    @checklist = Checklist.new
    @seo_carrier = OpenStruct.new title: "New checklist"
    respond_to do |format|
      format.html
    end
  end

  def edit
    @checklist = Checklist.find(params[:id])
    @seo_carrier = OpenStruct.new title: "Edit checklist: #{@checklist.name}"
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
          :hided,
          groups_attributes: [
              :id,
              :name,
              :prior,
              :_destroy,
              items_attributes: [
                  :id,
                  :title,
                  :sb_group,
                  :descr,
                  :prior,
                  :_destroy,
                  answers_attributes: [
                      :id,
                      :val,
                      :tip,
                      :commentable,
                      :prior,
                      :_destroy
                    ]
                ]
            ]
        )
    end
end
