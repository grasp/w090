# coding: utf-8
module Ruser
class UsersController < Ruser::RuserController
#class UsersController < ApplicationController
#include Ruser::ApplicationHelper
  before_filter :require_user, :only => "auth_unbind"
  before_filter :init_base_breadcrumb
  before_filter :set_menu_active
  before_filter :find_user, :only => [:show, :topics, :likes]
  def index
    @total_user_count = Ruser::User.count
     @active_users = Ruser::User.hot.limit(20)
      @recent_join_users = Ruser::User.recent.limit(20)
    drop_breadcrumb t("common.index"),:use_route=>"ruser"
  end

  def show
   # @topics = @user.topics.recent.limit(10)
   # @replies = @user.replies.only(:topic_id,:created_at).recent.includes(:topic).limit(10)
    set_seo_meta("#{@user.login}")
    drop_breadcrumb(@user.login,:use_route=>"ruser")
  end

  def topics
    @topics = @user.topics.recent.paginate(:page => params[:page], :per_page => 30)
    drop_breadcrumb(@user.login, ruser.user_path(@user.login))
    drop_breadcrumb(t("topics.title"),:use_route=>"ruser")
  end

  def likes
    @likes = @user.likes.recent.topics.paginate(:page => params[:page], :per_page => 30)
    drop_breadcrumb(@user.login, ruser.user_path(@user.login))
    drop_breadcrumb(t("users.menu.like"),:use_route=>"ruser")
  end

  def auth_unbind
    provider = params[:provider]
    if current_user.authorizations.count <= 1
      redirect_to ruser.edit_user_registration_path, :flash => {:error => t("users.unbind_warning")}
      return
    end

    current_user.authorizations.destroy_all(:conditions => {:provider => provider})
    redirect_to ruser.edit_user_registration_path, :flash => {:warring => t("users.unbind_success", :provider => provider.titleize )}
  end

  def location
    @location = Ruser::Location.find_by_name(params[:id])
    if @location.blank?
      render_404
      return 
    end
    
    @users = Ruser::User.where(:location_id => @location.id).desc('replies_count').paginate(:page => params[:page], :per_page => 30)

    if @users.count == 0
      render_404
      return
    end

    drop_breadcrumb(@location.name,:use_route=>"ruser")
  end

  protected
  def find_user
    @user = Ruser::User.where(:login => /^#{params[:id]}$/i).first
    render_404 if @user.nil?
  end

  def set_menu_active
    @current = @current = ['/users']
  end

  def init_base_breadcrumb
    drop_breadcrumb( t("menu.users"), ruser.users_path)
  end
  
  def routenav
    
  end
 
end
end
