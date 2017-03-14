class ProfilesController < FrontendController
  def show
    @user = User.find params[:id]
    @seo_carrier = OpenStruct.new({
        title: @user.name,
        seo_descr: "#{@user.name}, #{@user.position} at #{@user.company} — " \
                   "profile at #{setting_value(:app_humanized_name)}",
        seo_image: (@user.avatar.present? ? @user.avatar.url : nil)
      })
    respond_to do |format|
      format.html
    end
  end
end
