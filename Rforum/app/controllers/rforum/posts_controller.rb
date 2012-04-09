# coding: utf-8
class  Rforum::PostsController <  Rforum:: RforumController
   include Rforum::Engine.routes.url_helpers
  before_filter :require_user, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :set_menu_active

  def index
    scoped_posts = Rforum::Post.normal
    if !params[:tag].blank?
      scoped_posts = scoped_posts.by_tag(params[:tag])
    end
    @posts = scoped_posts.recent.paginate :page => params[:page], :per_page => 20
    set_seo_meta("文章")

    drop_breadcrumb("文章",:use_route => :rforum)
    if params[:tag]
      drop_breadcrumb(params[:tag],:use_route => :rforum)
    else
      drop_breadcrumb(t("posts.recent_publish_post"),:use_route => :rforum)
    end
  end

  def show
    @post = Rforum::Post.find(params[:id])
    @post.hits.incr
    set_seo_meta("#{@post.title}")
    drop_breadcrumb("文章",:use_route => :rforum)
    drop_breadcrumb(t("common.read"),:use_route => :rforum)
  end

  def new
    @post = Rforum::Post.new
  end

  def edit
    @post = Rforum::Post.find(params[:id])
    @post.tag_list = @post.tags.join(", ")
    drop_breadcrumb("文章",:use_route => :rforum)
    drop_breadcrumb(t("common.edit"),:use_route => :rforum)
  end

  def create
    @post = current_user.posts.build(params[:post])

    if @post.save
      redirect_to @post, notice: t("posts.submit_success")
    else
      render action: "new"
    end
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to @post, notice: '文章更新成功。'
    else
      render action: "edit"
    end
  end

  protected

  def set_menu_active
    @current = @current = ['/posts']
  end
end
