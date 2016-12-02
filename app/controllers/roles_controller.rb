class RolesController < ApplicationController

  #테스트용
  def remove
    user = User.find(current_user.id)
    user.remove_role 'evaluator'
    user.remove_role 'wikier'
    redirect_to :back
  end

  def evaluator
    user = User.find(current_user.id)
    user.add_role 'evaluator'
    redirect_to :back
  end

  def wikier
    user = User.find(current_user.id)
    user.add_role 'wikier'
    redirect_to :back
  end
end
