class RolesController < ApplicationController
  include RolesHelper
  #테스트용
  def remove
    current_user.remove_role 'evaluator'
    current_user.remove_role 'wikier'
    redirect_to :back
  end

  def resert
    point = 0
    current_user.update_attribute(:point, point)
    redirect_to :back
  end

  def charge
    point = 1000
    current_user.update_attribute(:point, point)
    redirect_to :back
  end

  def evaluator
    add_role_evaluator
  end

  def wikier
    add_role_wikier
  end

  #권한획득 시도 시 포인트 부족한 경우
  def lack
  end
end
