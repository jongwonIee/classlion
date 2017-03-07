class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end

  def create
    report = Report.new(report_params)
    report.user_id = @current_user.id
    if report.save
      redirect_to :back
    end
  end

  private
  def report_params
    params.require(:report).permit(:user_id, :evaluation_id, :title, :body)
  end
end
