module RolesHelper
  #권한부여 / 포인트 차감
  def add_role_evaluator
    user = current_user
    user.add_role 'evaluator'
    point = user.point - 1000
    user.update_attribute(:point, point)
    redirect_to request.env['HTTP_REFERER']
  end

  def add_role_wikier
    user = current_user
    user.add_role 'wikier'
    point = user.point - 1000
    user.update_attribute(:point, point)
    redirect_to request.env['HTTP_REFERER']
  end
end
