module EvaluationsHelper

  def all_evaluations
    return Evaluation.all.order(created_at: :desc)
  end
end
