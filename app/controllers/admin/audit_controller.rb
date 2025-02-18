module Admin
  class AuditController < AdminController
    before_action :authenticate_user!, only: [ :index ]
    include Pagy::Backend

    def index
      @pagy_post_audits, @post_audits = pagy(Audited::Audit.where(auditable_type: "Post"), limit: 5)
    end
  end
end
