class ReportsController < ApplicationController

  before_action :activation_check

  def new
    @report = Report.new
  end

  def create
    report = Report.new(report_params)
    report.user_id = @current_user.id
    if !report.save
      flash[:warning] = '문제가 발생했습니다.'
    end
    redirect_to :back
  end

  private
  def report_params
    params.require(:report).permit(:user_id, :evaluation_id, :body)
  end
end
