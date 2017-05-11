class WikisController < ApplicationController

  def send_wiki
    wiki = Wiki.new(      user: current_user, 
                     course_id: params[:course_id],
                          body: params[:content])
    wiki.get_new_revision
    wiki.save
    render json: {:message => "success"}, :status => :ok
  end
end
