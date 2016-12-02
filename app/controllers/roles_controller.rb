class RolesController < ApplicationController
  def evaluator
    user = User.find(current_user.id)
    user.add_role 'evaluator'
  end

  def wikier
    user = User.find(current_user.id)
    user.add_role 'wikier'
  end
end
