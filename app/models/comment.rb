include ActionView::Helpers::DateHelper
class Comment < ApplicationRecord
  belongs_to :evaluation
  belongs_to :user

  validates :body, presence: true #값이 비어있으면 안됨

  def time_ago
    #강평의 댓글 작성 시간
    if (time_ago_in_words(self.created_at)) == "1분 이하"
      return '방금 전'
    elsif (time_ago_in_words(self.created_at)).last == '분' or (time_ago_in_words(self.created_at)).last == '간'
      return time_ago_in_words(self.created_at) + " 전"
    elsif (time_ago_in_words(self.created_at)).last == '일' and (time_ago_in_words(self.created_at)).chomp('일').to_i < 8
      return time_ago_in_words(self.created_at) + " 전"
    else
      return ActionController::Base.helpers.time_tag(self.created_at, :format=>'%Y년 %m월 %d일')
    end
  end

  def self.create_comment(body, user_id, evaluation_id)
    comment = Comment.new
    comment.body = body
    comment.user_id = user_id
    comment.evaluation_id = evaluation_id
    if comment.save
      { message: '댓글작성이 완료!', status: :ok }
    else
      { message: '문제가 발생했습니다.', status: :bad_request }
    end
  end
end
