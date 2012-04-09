# coding: utf-8
class Rforum::CommentsController < Rforum::RforumController
  before_filter :require_user

  def create
    @comment = Rforum::Comment.new(params[:comment])
    @comment.user = current_user
    @success = @comment.save
  end
end
