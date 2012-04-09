# coding: utf-8
class Rforum::Cpanel::TopicsController < Rforum::Cpanel::ApplicationController

  def index
    @topics = Rforum::Topic.unscoped.desc(:_id).includes(:user).paginate :page => params[:page], :per_page => 30

  end

  def show
    @topic = Rforum::Topic.unscoped.find(params[:id])

  end


  def new
    @topic = Rforum::Topic.new
  end

  def edit
    @topic = Rforum::Topic.unscoped.find(params[:id])
  end

  def create
    @topic = Rforum::Topic.new(params[:topic])

    if @topic.save
      redirect_to(cpanel_topics_path, :notice => 'Topic was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @topic = Rforum::Topic.unscoped.find(params[:id])

    if @topic.update_attributes(params[:topic])
      redirect_to(cpanel_topics_path, :notice => 'Topic was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @topic = Rforum::Topic.unscoped.find(params[:id])
    @topic.destroy_by(current_user)

    redirect_to(cpanel_topics_path)
  end

  def undestroy
    @topic = Rforum::Topic.unscoped.find(params[:id])
    @topic.update_attribute(:deleted_at, nil)
    redirect_to(cpanel_topics_path)
  end

  def suggest
    @topic = Rforum::Topic.unscoped.find(params[:id])
    @topic.update_attribute(:suggested_at, Time.now)
    Rforum::CacheVersion.topic_last_suggested_at = Time.now
    redirect_to(cpanel_topics_path, :notice => "Topic:#{params[:id]} suggested.")
  end

  def unsuggest
    @topic = Rforum::Topic.unscoped.find(params[:id])
    @topic.update_attribute(:suggested_at, nil)
    Rforum::CacheVersion.topic_last_suggested_at = Time.now
    redirect_to(cpanel_topics_path, :notice => "Topic:#{params[:id]} unsuggested.")
  end
end
