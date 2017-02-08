class RolesController < ApplicationController
  include RolesHelper
  #테스트용
  def remove
    user = User.find(current_user.id)
    user.remove_role 'evaluator'
    user.remove_role 'wikier'
    redirect_to :back
  end

  def resert
    user = User.find(current_user.id)
    point = 0
    user.update_attribute(:point, point)
    redirect_to :back
  end

  def charge
    user = User.find(current_user.id)
    point = 1000
    user.update_attribute(:point, point)
    redirect_to :back
  end

  def evaluator
    add_role_evaluator
  end

  def wikier
    add_role_wikier
  end

  def lack
  end
end
