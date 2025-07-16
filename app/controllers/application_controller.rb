class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :set_my_reports, if: :user_signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  def set_my_reports
    @my_reports = current_user.reports.order(created_at: :desc).limit(6)
  end
end
