class CommentsController < ApplicationController

  def create
    #댓글 생성 #validation은 아니지만 user랑 걍 맞춰
    validation = Comment.create_comment(params[:body], current_user.id,
                                        params[:evaluation_id])
    # if validation[:status] == '200'
    #   flash[:success] = validation[:message]
    # else
    #   flash[:warning] = validation[:message]
    # end
    render json: { message: validation[:message], body: params[:body],
                   nickname: current_user.nickname,
                   comment: validation[:comment_id] }, status: validation[:status]
  end

  def destroy
   #댓글 삭제
   @comment = Comment.find(params[:id])
   #TODO
   respond_to do |format|
     if @comment.destroy
       format.js
       format.json { head :no_content }
     end
   end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :evaluation_id)
  end
end
