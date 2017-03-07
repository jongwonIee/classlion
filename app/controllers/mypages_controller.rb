class MypagesController < ApplicationController
  include MypagesHelper

  def index
    @evaluations = @current_user.evaluations.order(created_at: :desc)

    @comments = []
    Comment.where('user_id =?', @current_user.id).each do |c|
      @comments << c
    end
    @comments.reverse!

    @favorite_courses = []
    Favorite.where('user_id =?', @current_user.id).each do |f|
      @favorite_courses << Course.find(f.course_id)
    end
    @favorite_courses.reverse!

    @reports = Report.where('user_id =?', @current_user.id).order(created_at: :desc)
  end
end