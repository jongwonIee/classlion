class EvaluationsController < ApplicationController
  include EvaluationsHelper

  def index
    @evaluations = all_evals
  end
end
