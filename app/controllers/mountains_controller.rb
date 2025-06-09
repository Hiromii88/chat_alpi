class MountainsController < ApplicationController
  def index
    q_params = {
      area_cont: params[:area],
      level_eq: params[:level],
      name_or_feature_cont: params[:keyword]
    }.delete_if { |_, v| v.blank? }

    @q = Mountain.ransack(q_params)
    @mountains = @q.result.order(created_at: :asc).page(params[:page]).per(12)
  end

  def show
    @mountain = Mountain.find(params[:id])
  end

  def new
    @mountain = Mountain.new
  end

  def create
    @mountain = Mountain.new(mountain_params)
    if @mountain.save
      redirect_to @mountain, notice: '山を作成しました'
    else
      redirect_to mountains_path
    end
  end

  def edit
    @mountain = Mountain.find(params[:id])
  end

  def update
    @mountain = Mountain.find(params[:id])

    if @mountain.update(mountain_params)
      redirect_to mountain_path(@mountain), notice: "山情報を更新しました"
    else
      flash.now[:alert] = "山情報を更新できませんでした"
      render :edit
    end
  end

  def destroy
    @mountain = Mountain.find(params[:id])

    @mountain.destroy!
    redirect_to mountains_path, notice: "山情報を削除しました"
  end

  private

  def mountain_params
    params.require(:mountain).permit(:name, :height, :level, :feature, :route_distance, :prefecture, :image)
  end
end
