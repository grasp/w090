# coding: utf-8
class Rforum::SearchController < Rforum::RforumController
  def index
    search_text = params[:q]
    @search = Sunspot.search(Rforum::Topic) do
      keywords search_text, :highlight => true
      paginate :page => params[:page], :per_page => 20
      order_by :replied_at, :desc
    end

    set_seo_meta("#{t("common.search")}: #{params[:q]}")
    drop_breadcrumb("#{t("common.search")}: #{params[:q]}",:use_route => :rforum)
  end

  def wiki
    search_text = params[:q]
    @search = Sunspot.search(Rforum::Page) do
      keywords search_text, :highlight => true
      paginate :page => params[:page], :per_page => 20
    end

    set_seo_meta("WIKI#{t("common.search")}: #{params[:q]}")
    drop_breadcrumb("WIKI#{t("common.search")}: #{params[:q]}",:use_route => :rforum)
  end
end
