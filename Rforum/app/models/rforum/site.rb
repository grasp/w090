# coding: utf-8
#module Rforum
class Rforum::Site
  include Mongoid::Document
  include Mongoid::Timestamps
  include Rforum::Mongoid::BaseModel
  include Rforum::Mongoid::SoftDelete
  include Rforum::Mongoid::CounterCache

  field :name
  field :url
  field :desc
  field :favicon

  belongs_to :site_node ,:class_name=>"Rforum::SiteNode"
  counter_cache :name => :site_node, :inverse_of => :sites
  belongs_to :user ,:class_name=>"Ruser::User"

  validates_presence_of :url, :name, :site_node_id
  
  index :url

  before_validation :fix_urls, :check_uniq
  def fix_urls
    if self.favicon.blank?
      self.favicon = self.favicon_url
    else
      if self.favicon.match(/:\/\//).blank?
        self.favicon = "http://#{self.favicon}"
      end
    end

    if !self.url.blank?
      url = self.url.gsub(/http[s]{0,1}:\/\//,'').split('/').join("/")
      self.url = "http://#{url}"
    end
  end
  
  def check_uniq
    if Rforum::Site.unscoped.or(:url => url).count > 0
  #if self.unscoped.or(:url => url).count > 0
      self.errors.add(:url,"已经提交过了。")
      return false
    end
  end

  def favicon_url
    return "" if self.url.blank?
    domain = self.url.gsub("http://","")
    "http://www.google.com/profiles/c/favicons?domain=#{domain}"
  end
end
#end