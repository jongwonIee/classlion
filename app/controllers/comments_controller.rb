class CommentsController < ApplicationController

  def create
    #댓글 생성
    @comment = Comment.new(comment_params)
    @comment.evaluation_id = params[:evaluation_id]
    @comment.user = @current_user
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #댓글 삭제
   @comment = Comment.find(params[:id])
   respond_to do |format|
     if @comment.destroy
       format.js
       format.json { head :no_content }
     end
   end
  end


  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
