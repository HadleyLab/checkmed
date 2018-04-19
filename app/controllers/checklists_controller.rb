class ChecklistsController < FrontendController
  before_action :authenticate_user!

  # The Search page
  def index
    @seo_carrier = OpenStruct.new({ title: "Search checklists" })

    # al'a settings
    default_ordering = { name: :asc }
    checklists_per_page = 20

    @checklists = Checklist.visibles.joins(:user)
    @have_a_filter = false

    if params[:sf] && (params[:sf][:q].present? ||
                       params[:sf][:type].present? ||
                       params[:sf][:eri].present? ||
                       params[:sf][:spc].present?)
      @have_a_filter = true

      if params[:sf][:q].present?
        sq = params[:sf][:q]
        @checklists = @checklists.
          where("checklists.name ILIKE ? OR "\
                "checklists.descr ILIKE ? OR " \
                "users.name ILIKE ? OR " \
                "users.company ILIKE ? OR " \
                "users.academ_inst ILIKE ? OR " \
                "users.position ILIKE ?",
                "%#{sq}%", "%#{sq}%", "%#{sq}%", "%#{sq}%", "%#{sq}%", "%#{sq}%")
      end

      if params[:sf][:eri].present?
        @checklists = @checklists.where(executor_role_id: params[:sf][:eri])
      end

      if params[:sf][:spc].present?
        @checklists = @checklists.where(speciality_id: params[:sf][:spc])
      end

      if params[:sf][:ord].present?
        @checklists = case params[:sf][:ord]
                      when 'dn' then @checklists.order(name: :asc)
                      when 'an' then @checklists.order('users.name ASC')
                      when 'dc' then @checklists.order(created_at: :asc)
                      when 'hn' then @checklists.order('users.company ASC')
                      else
                        @checklists.order(default_ordering)
                      end
      end
    else
      @checklists = @checklists.order(default_ordering)
    end

    @checklists_full_count = @checklists.count

    @checklists = @checklists.page(params[:page]).per(checklists_per_page)
    @start_order_index = [0, params[:page].to_i - 1].max * checklists_per_page

    respond_to do |format|
      format.html
    end
  end

  def show
    @checklist = Checklist.find params[:id]
    @user = @checklist.user

    seo_descr = "Checklist \"#{@checklist.name}\" for #{@checklist.executor_role.name}"
    seo_descr += " by #{@user.name}, #{@user.position} at #{@user.company}"
    seo_descr += " — #{setting_value(:app_humanized_name)}"
    @seo_carrier = OpenStruct.new({
      title: "Checklist \"#{@checklist.name}\"",
      seo_descr: seo_descr,
      seo_image: (@user.avatar.present? ? @user.avatar.url : nil)
    })

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

    # Add default groups
    @checklist.groups.build name: 'Subtitle',       prior: 0

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
          :speciality_id,
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
                  :picture,
                  :picture_cache,
                  :remove_picture,
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
