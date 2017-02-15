class CommentsController < ApplicationController

  def create #디비에 넣는다
    comment = Comment.new(comment_params)
    comment.user = @current_user
    comment.save
    # if comment.save
    #   redirect_to :back
    # end
    respond_to do |format|
      format.js
      format.html
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:evaluation_id, :body)
  end
end
