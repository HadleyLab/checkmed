class ProfilesController < FrontendController
  before_action :authenticate_user!

  def show
    @user = User.find params[:id]

    @seo_carrier = OpenStruct.new({
        title: @user.name,
        seo_descr: "#{@user.name}, #{@user.position} at #{@user.company} — " \
                   "profile at #{setting_value(:app_humanized_name)}",
        seo_image: (@user.avatar.present? ? @user.avatar.url : nil)
      })

    @checklists = @user.checklists.visibles.ordered

    # search
    if params[:sf] && (params[:sf][:q].present? || params[:sf][:eri].present?)
      @found_checklists = Checklist.visibles.joins(:user)

      if params[:sf][:q].present?
        sq = params[:sf][:q]
        @found_checklists = @found_checklists.
          where("checklists.name ILIKE ? OR checklists.descr ILIKE ? OR " \
                "users.name ILIKE ? OR users.company ILIKE ? OR users.position ILIKE ?",
                "%#{sq}%", "%#{sq}%", "%#{sq}%", "%#{sq}%", "%#{sq}%")
      end

      if params[:sf][:eri].present?
        @found_checklists = @found_checklists.where(executor_role_id: params[:sf][:eri])
      end

      if params[:sf][:ord].present?
        @found_checklists = case params[:sf][:ord]
                            when 'dn'
                              @found_checklists.order(name: :asc)
                            when 'an'
                              @found_checklists.order('users.name ASC')
                            when 'dc'
                              @found_checklists.order(created_at: :asc)
                            when 'hn'
                              @found_checklists.order('users.company ASC')
                            else
                              @found_checklists
                            end
      end
    end

    # recently browsed
    @recent_checklists = Checklist.visibles.
                                   joins(:users_visits).
                                   where(users_checklists_visits: { user_id: @user.id }).
                                   group(:id)
                                   # TODO correct ordering of the recent browsed checklists

    respond_to do |format|
      format.html
    end
  end

  def redirect_to_show
    if user_signed_in?
      redirect_to account_path(current_user)
    else
      redirect_to root_path
    end
  end
end
