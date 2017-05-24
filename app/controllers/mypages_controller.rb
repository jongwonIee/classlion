class MypagesController < ApplicationController
  include MypagesHelper
  before_action :session_check

  def index
    @evaluations = @current_user.evaluations.order(created_at: :desc)
    @comments = @current_user.comments.reverse
    @favorite_courses = []

    @current_user.favorites.each do |f|
      @favorite_courses << Course.find(f.course_id)
    end

    @favorite_courses.reverse!
  end
end
