class FavoritesController < ApplicationController
  def create
    @report = Report.find(params[:report_id])
    current_user.favorite(@report)
  end

  def destroy
    @report = current_user.favorites.find(params[:id]).report
    current_user.unfavorite(@report)
  end
end
