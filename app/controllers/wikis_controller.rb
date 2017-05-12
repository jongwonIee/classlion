class WikisController < ApplicationController

  def send_wiki
    tries = 3
    previous_wiki = Wiki.where(course_id: params[:course_id]).order("revision desc").take
    wiki = Wiki.new(      user: current_user, 
                     course_id: params[:course_id],
                          body: params[:content],
                       comment: params[:comment])
    wiki.diff = if previous_wiki.nil? then 0 else 100 end
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

  def history
    @wiki_history = Wiki.where(course_id: params[:id])
  end
end
