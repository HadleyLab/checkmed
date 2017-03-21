class ProfilesController < FrontendController
  def show
    @user = User.find params[:id]

    @seo_carrier = OpenStruct.new({
        title: @user.name,
        seo_descr: "#{@user.name}, #{@user.position} at #{@user.company} — " \
                   "profile at #{setting_value(:app_humanized_name)}",
        seo_image: (@user.avatar.present? ? @user.avatar.url : nil)
      })

    @checklists = @user.checklists.visibles.ordered.includes(:executor_role)

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
