class Rforum::Cpanel::CommentsController < Rforum::Cpanel::ApplicationController
  respond_to :js, :html, :only => [:destroy]

  def index
    @comments = Rforum::Comment.recent.paginate(:page => params[:page], :per_page => 20)
  end

  def edit
    @comment = Rforum::Comment.find(params[:id])
  end

  def update
    @comment = Rforum::Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to cpanel_comments_path(@cpanel_comment), notice: 'Comment was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @comment = Rforum::Comment.find(params[:id])
    @comment.destroy
    respond_with do |format|
      format.html { redirect_to cpanel_comments_path }
      format.js { render :layout => false }
    end
  end
end
