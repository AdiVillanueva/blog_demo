class AuditController < ApplicationController
  before_action :require_admin, only: [ :index ]

  def index
    @user_audits = Audited::Audit.where(auditable_type: "User")
    @post_audits = Audited::Audit.where(auditable_type: "Post")
  end

  private

  def require_admin
    unless current_user.isAdmin?
      redirect_to root_path, alert: "You do not have permission to view this page."
    end
  end
end
