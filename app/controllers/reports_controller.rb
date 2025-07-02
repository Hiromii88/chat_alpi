class ReportsController < ApplicationController
  def index
    @q = Report.ransack(title_or_content_cont: params[:keyword])
    @reports = @q.result.order(created_at: :desc).page(params[:page]).per(12)
  end
  def show
    @report = Report.find(params[:id])
    @report_logs = Report.where(user_id: @report.user_id).where.not(id: @report.id)
  end
  def new
    @report = Report.new
  end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to @report, notice: 'レポートを投稿しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @report = current_user.reports.find(params[:id])
  end

  def update
    @report = current_user.reports.find(params[:id])
    if @report.update(report_params)
      redirect_to @report, notice: 'レポートを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report = current_user.reports.find_by(id: params[:id])
    if @report
      @report.destroy
      redirect_to reports_path, notice: 'レポートを削除しました'
    else
      redirect_to reports_path, alert: '削除できるレポートが見つかりません'
    end
  end

  private

  def report_params
    params.require(:report).permit(:title, :content, :image, :mountain_id)
  end

end
