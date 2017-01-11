class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create #디비에 넣는다
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to :back
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :evaluation_id, :body)
  end
end