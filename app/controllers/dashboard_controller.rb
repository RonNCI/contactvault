class DashboardController < ApplicationController
  # ensure user is logged in before accessing dashboard
  before_action :require_login

  # display dashboard index page
  def index
    # set current user as vault user
    @vault_user = current_user
  end
end
