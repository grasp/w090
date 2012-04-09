# coding: utf-8
class Rforum::TopicsController <Rforum::RforumController
  include Rforum::CellHelper
  include Rforum::NotesHelper
     include Rforum::Engine.routes.url_helpers
  layout "rtheme/rforum"
  load_and_authorize_resource  :only => [:new,:edit,:create,:update,:destroy],:class=>"Rforum::Topic"

  before_filter :set_menu_active
  caches_page :feed, :node_feed, :expires_in => 1.hours
  before_filter :init_base_breadcrumb

  def index
    @topics = Rforum::Topic.last_actived.fields_for_list.limit(15).includes(:user)
    @sections = Rforum::Section.all
    @hot_locations = Ruser::Location.hot.limit(12) #ugly code 
    @suggest_topics = Rforum::Topic.suggest.limit(5)
    set_seo_meta("","#{Rforum::Setting.app_name}#{t("menu.topics")}")
    drop_breadcrumb(t("topics.hot_topic"),:use_route => :rforum)
    #render :stream => true
  end

  def feed
    @topics = Rforum::Topic.recent.fields_for_list.limit(20).includes(:node,:user, :last_reply_user)
    response.headers['Content-Type'] = 'application/rss+xml; charset=utf-8'
    render :layout => false
  end

  def node
    @node = Rforum::Node.find(params[:id])
    @topics = @node.topics.last_actived.fields_for_list.includes(:user).paginate(:page => params[:page],:per_page => 50)
    set_seo_meta("#{@node.name} &raquo; #{t("menu.topics")}","#{Rforum::Setting.app_name}#{t("menu.topics")}#{@node.name}",@node.summary)
    drop_breadcrumb("#{@node.name}",:use_route => :rforum)
    render :action => "index" #, :stream => true
  end

  def node_feed
    @node = Rforum::Node.find(params[:id])
    @topics = @node.topics.recent.fields_for_list.limit(20)
    response.headers["Content-Type"] = "application/rss+xml"
    render :layout => false
  end

  def recent
    # TODO: 需要 includes :node,:user, :last_reply_user,但目前用了 paginate 似乎会使得 includes 没有效果
    @topics = Rforum::Topic.recent.fields_for_list.includes(:user).paginate(:page => params[:page], :per_page => 50)
    drop_breadcrumb(t("topics.topic_list"),:use_route => :rforum)
    render :action => "index" #, :stream => true
  end

  def search
    result = Redis::Search.query("Topic", params[:key], :limit => 500)
    ids = result.collect { |r| r["id"] }
    @topics = Rforum::Topic.where(:_id.in => ids).limit(50).includes(:node,:user, :last_reply_user)
    set_seo_meta("#{t("common.search")}#{params[:s]} &raquo; #{t("menu.topics")}")
    drop_breadcrumb("#{t("common.search")} #{params[:key]}",:use_route => :rforum)
    render :action => "index" #, :stream => true
  end

  def show
    @topic = Rforum::Topic.without_body.includes(:user, :node).find(params[:id])
    @topic.hits.incr(1)
    @node = @topic.node
    @replies = @topic.replies.without_body.asc(:_id).all.includes(:user).reject { |r| r.user.blank? }
    if current_user
      current_user.read_topic(@topic)
      # TODO: 此处导致每次查看帖子都会执行 update 需要改进
      current_user.notifications.where(:reply_id.in => @replies.map(&:id), :read => false).update_all(:read => true)
    end
    set_seo_meta("#{@topic.title} &raquo; #{t("menu.topics")}")
    drop_breadcrumb("#{@node.name}", rforum.node_topics_path(@node.id))
    drop_breadcrumb(t("topics.read_topic"),:use_route => :rforum)
    # render :stream => true
  end

  def new
    @topic = Rforum::Topic.new
    if !params[:node].blank?
      @topic.node_id = params[:node]
      @node = Rforum::Node.find_by_id(params[:node])
      if @node.blank?
        render_404
      end
      drop_breadcrumb("#{@node.name}", rforum.node_topics_path(@node.id))
    end
    drop_breadcrumb(t("topics.post_topic"),:use_route => :rforum)
    set_seo_meta("#{t("topics.post_topic")} &raquo; #{t("menu.topics")}")
  end

  def edit
    @topic = Rforum::Topic.find(params[:id])
    @node = @topic.node
    drop_breadcrumb("#{@node.name}", rforum.node_topics_path(@node.id))
    drop_breadcrumb(t("topics.edit_topic"),:use_route => :rforum)
    set_seo_meta("#{t("topics.edit_topic")} &raquo; #{t("menu.topics")}")
  end

  def create
    pt = params[:topic]
    @topic = Rforum::Topic.new(pt)
    @topic.user_id = current_user.id
    @topic.node_id = params[:node] || pt[:node_id]

    if @topic.save
      redirect_to(topic_path(@topic.id), :notice => t("topics.create_topic_success"))
    else
      render :action => "new"
    end
  end

  def preview
    @body = params[:body]

    respond_to do |format|
      format.json
    end
  end

  def update
    @topic = Rforum::Topic.find(params[:id])
    pt = params[:topic]
    @topic.node_id = pt[:node_id]
    @topic.title = pt[:title]
    @topic.body = pt[:body]

    if @topic.save
      redirect_to(topic_path(@topic.id), :notice =>  t("topics.update_topic_success"))
    else
      render :action => "edit"
    end
  end

  def destroy
    @topic = Rforum::Topic.find(params[:id])
    @topic.destroy_by(current_user)
    redirect_to(topics_path, :notice => t("topics.delete_topic_success"))
  end

  protected

  def set_menu_active
    @current = @current = ['/topics']
  end

  def init_base_breadcrumb
    drop_breadcrumb(t("menu.topics"), rforum.topics_path)
  end

  private

  def init_list_sidebar
    if !fragment_exist? "topic/init_list_sidebar/hot_nodes"
      @hot_nodes = Rforum::Node.hots.limit(10)
    end
    set_seo_meta(t("menu.topics"))
  end
end
