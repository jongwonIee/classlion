class WikisController < ApplicationController

  def send_wiki
    tries = 3
    wiki = Wiki.new(      user: current_user, 
                     course_id: params[:course_id],
                          body: params[:content])
  begin
    wiki.get_new_revision
    wiki.save!
    render json: {:message => "success"}, :status => :ok
  rescue ActiveRecord::RecordInvalid
    sleep((Random.rand(10) + 1) / 10.0)
    retry unless (tries -= 1) <= 0
    render json: {:message => "fail"}, :status => :bad_request
  end
  end
end
