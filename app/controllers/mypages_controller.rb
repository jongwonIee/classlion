class MypagesController < ApplicationController
  include MypagesHelper

  def index
    #자신이 쓴 강의평
    @favorite_courses = []
    @evaluations = @current_user.evaluations
    Favorite.where('user_id =?', @current_user.id).each do |f|
      @favorite_courses << Course.find(f.course_id)
    end
  end
end
