class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  layout 'seoless'

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   begin
  #     super
  #   rescue Exception => e
  #     @excp_err = e
  #     self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  #     # respond_with resource, location: edit_user_registration_path(resource)
  #     render :edit
  #   end
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def update_resource(resource, params)
    if params.has_key? :password
      resource.update_with_password(params)
    else
      resource.update_without_password(params)
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
        :name,
        :company,
        :position,
        :avatar,
        :avatar_cache
      ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
        :name,
        :company,
        :position,
        :avatar,
        :avatar_cache,
        :remove_avatar
      ])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    # super(resource)
    account_path(resource)
  end

  # The default url to be used after updating a resource. You need to overwrite
  def after_update_path_for(resource)
    # super(resource)
    account_path(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
