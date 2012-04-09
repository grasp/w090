# coding: utf-8
class Rforum::Cpanel::ApplicationController < ApplicationController
  layout "rtheme/cpanel"
  before_filter :require_user
  before_filter :require_admin
  include Ruser::UsersHelper

  def require_admin
    if not Ruser::Setting.admin_emails.include?(current_user.email)
      render_404
    end
  end
end
