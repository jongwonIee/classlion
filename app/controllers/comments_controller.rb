class CommentsController < ApplicationController

  def create #디비에 넣는다
    comment = Comment.new(comment_params)
    comment.user = @current_user
    if comment.save #저장이 잘 되었으면
      render json: { msg: "save" }
    else #문제가 생겼으면
      render json: { msg: "no save" }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:evaluation_id, :body)
  end
end
