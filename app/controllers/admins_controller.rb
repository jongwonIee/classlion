class AdminsController < ApplicationController
  before_action :activation_check

  def index #TODO : 반드시 제한 걸 것
    @reports = Report.all.order(created_at: :desc)
  end
end
