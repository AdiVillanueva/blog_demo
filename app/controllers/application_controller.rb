class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pagy::Backend
  allow_browser versions: :modern
  before_action :set_audited_user

  private

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      admin_posts_path
    elsif resource.is_a?(Customer)
      root_path
    else
      root_path
    end
  end

  def current_auditor
    current_user || current_customer
  end

  def set_audited_user
    Audited.store[:current_user] = -> { current_auditor }
  end
end
