class WikisController < ApplicationController

  def send_wiki
    wiki = Wiki.new 
    wiki.user = current_user
    wiki.course_id = params[:course_id]
    wiki.body = params[:content]
    if wiki.save
      render json: {:message => "success"}, :status => :ok
    else
      render json: {:message => "fail"}, :status => :bad_request
    end
  end
end
