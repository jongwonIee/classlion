class WikisController < ApplicationController
  def send_wiki
    tries = 3
    wiki = Wiki.new(      user: current_user, 
                     course_id: params[:course_id],
                          body: params[:content],
                       comment: params[:comment])
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

  def show
    if current_user.has_role?('wikier')
      @course = Course.find(params[:id]) #FE작업 중 임시추가-검토 바람
      @wiki = Wiki.where(course_id: params[:id]).where(revision: params[:revision]).take
    end
  end

  def diff
    if current_user.has_role?('wikier')
      @course = Course.find(params[:id]) #FE작업 중 임시추가-검토 바람
      wiki_1 = Wiki.where(course_id: params[:id]).where(revision: params[:rev_1]).take
      wiki_2 = Wiki.where(course_id: params[:id]).where(revision: params[:rev_2]).take
      @diff = Diffy::Diff.new(wiki_1.body, wiki_2.body, :format => :html)
    end
  end

  def rollback
    tries = 3
    previous_wiki = Wiki.where(course_id: params[:id]).where(revision: params[:revision]).take
    wiki = Wiki.new(      user: current_user, 
                     course_id: params[:id],
                          body: previous_wiki.body,
                      rollback: previous_wiki.revision,
                       comment: params[:comment])
  begin
    wiki.get_new_revision
    wiki.save!
  rescue ActiveRecord::RecordInvalid
    sleep((Random.rand(10) + 1) / 10.0)
    retry unless (tries -= 1) <= 0
  end
    redirect_to "/wiki/#{params[:id]}/history"
  end

  def history
    if current_user.has_role?('wikier')
      @course = Course.find(params[:id]) #FE작업 중 임시추가-검토 바람
      @wiki_history = Wiki.where(course_id: params[:id]).order("revision desc")
    end
  end
end
