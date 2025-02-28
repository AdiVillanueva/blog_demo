class AdminController < ApplicationController
  before_action :authenticate_user!
  include Pagy::Backend
  include Pagy::Frontend

  def audit
  end
end
