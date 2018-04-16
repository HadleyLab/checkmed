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

    @checklists = @user.checklists.published.visibles.ordered
    @unpublished_checklists = @user.checklists.unpublished.visibles.ordered

    @recent_checklists = Checklist.
        visibles.
        joins(:users_visits).
        where(users_checklists_visits: { user_id: @user.id }).
        group(:id).
        limit(20)
        # TODO correct ordering of the recent browsed checklists by last visited

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
