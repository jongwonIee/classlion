class RolesController < ApplicationController
  include RolesHelper
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
