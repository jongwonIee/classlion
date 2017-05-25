module RolesHelper
  #TODO model로 move
  def add_role_evaluator
    user = current_user
    user.add_role 'evaluator'
    point = user.point - 1000
    user.update_attribute(:point, point)
    redirect_back(fallback_location: root_path)
  end

  def add_role_wikier
    user = current_user
    user.add_role 'wikier'
    point = user.point - 1000
    user.update_attribute(:point, point)
    redirect_back(fallback_location: root_path)
  end
end
