class MypagesController < ApplicationController
  include MypagesHelper

  def index
    #자신이 쓴 강의평
    @evaluations = []
    all_evaluations.each do |e|
      if e.user_id == current_user.id
        @evaluations << e
      end
    end
  end
end
