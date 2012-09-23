module ApplicationHelperCommon
  def notice_message
    flash_messages = []

    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("x", "#", :class => "close",:"data-dismiss"=>"alert") + message, :class => "alert alert-#{type} fade in")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end

  def admin?(user = nil)
    user ||= current_user
    user.try(:admin?)
  end
#should be move out
  def wiki_editor?(user = nil)
    user ||= current_user
    user.try(:wiki_editor?)
  end

  def owner?(item)
    return false if item.blank? or current_user.blank?
    item.user_id == current_user.id
  end

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end

  def render_page_title
    #Here is a bug, as we debug Ruser, so use Ruser as first
    title = @page_title ? "#{@page_title} | #{Ruser::Setting.app_name}" : Ruser::Setting.app_name rescue "#{Ruser::Setting.app_name}"
    content_tag("title", title, nil, false)
  end

  # 去除区域里面的内容的换行标记
  def spaceless(&block)
    data = with_output_buffer(&block)
    data = data.gsub(/\n\s+/,"")
    data = data.gsub(/>\s+</,"><")
    raw data
  end

  def facebook_enable
    Ruser::Setting.facebook_enable
  end
  
MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                        'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                        'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                        'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                        'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'

  def mobile?
    agent_str = request.user_agent.to_s.downcase
    return false if agent_str =~ /ipad/
    agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
  end
end