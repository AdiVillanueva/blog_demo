class Admin::AuditController < ApplicationController
  before_action :require_admin, only: [ :index ]
  include Pagy::Backend

  def index
    @pagy, @user_audits = pagy(Audited::Audit.where(auditable_type: "User"), limit: 5)
    @pagy, @post_audits = pagy(Audited::Audit.where(auditable_type: "Post"), limit: 5)
  end

  private

  def require_admin
    unless current_user.isAdmin?
      redirect_to root_path, alert: "You do not have permission to view this page."
    end
  end
end
