# frozen_string_literal: true

module Admin
  class SessionsController < Devise::SessionsController
    # layout "devise"

    # GET /login
    def new
      super
    end

    # POST /admin/login
    def create
      # super
      self.resource = User.find_by_email(params[:user][:email].downcase)
      if User.find_by_email(params[:user][:email].downcase)&.valid_password?(params[:user][:password])
        # if self.resource.active?
        sign_in(resource_name, resource)
        yield resource if block_given?

        respond_with resource, location: after_sign_in_path_for(resource), turbo: false
        # else
        # resource.errors.add(:inactive, "account, please contact support")
        # render :new
        # end
      else
        if resource.nil?
          @user = User.new
          @user.errors.add(:invalid, "email or password.")
        else
          resource.errors.add(:invalid, "email or password.")
        end
        render :new
      end
    end

    # DELETE /resource/sign_out
    def destroy
      super
      # Clear the admin_return_to in session.
      session[:admin_return_to] = nil
      flash.discard(:notice) # Remove the signed out successfully message.
    end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [ :attribute ])
    end

    private

    # Overwriting the sign_in redirect path method
    def after_sign_in_path_for(resource)
      stored_location_for(resource)  || admin_posts_path
    end

    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for(resource)
      new_user_session_path
    end
  end
end
