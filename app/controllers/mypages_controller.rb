class MypagesController < ApplicationController
  include MypagesHelper

  def index
    #자신이 쓴 강의평
    @evaluations = current_user.evaluations
  end
end
