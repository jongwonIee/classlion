class EvaluationsController < ApplicationController
  include EvaluationsHelper

  def index
    @evaluations = all_evaluations
  end

end
