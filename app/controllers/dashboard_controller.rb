class DashboardController < ApplicationController
  # ensure user is logged in before accessing dashboard
  before_action :require_login

  def index
    # get current user for vault access
    @vault_user = current_user
    # fetch 5 most recent activities for the user
    @recent_activities = current_user.activities.order(created_at: :desc).limit(5)
    # get total number of contacts for the user
    @contact_count = current_user.contacts.count
  end
end
