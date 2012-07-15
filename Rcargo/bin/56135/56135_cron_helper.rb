#coding:utf-8
#require 'active_support'

def run_56135_cargo_cron(logger)

    logger.info "56135_cargo_helper"
    mechanize=Mechanize.new  

	  all_raw_cargo=Array.new 
    (7..16).include?(Time.now.hour) ? @page_count=5 : @page_count=1  #in busy time ,we need fetch more page  
    @page_count.downto(1).each do |i| #each time we parse 3 page
      mechanize.get("http://www.56135.com/56135/trade/tradeindex///#{i}.html") do |page|
        logger.info "start to parse 56135 page"
        page.parser.css("div.all_info2").each do |entrycontainer|
          cargo=Hash.new    

          full_line_text=entrycontainer.css("div.t_info01 a").text.to_s#
          logger.info "full_line_text=#{full_line_text}"

           lininfo=entrycontainer.css("div.t_info01 a").to_s.force_encoding("gb2312")
           logger.info "lininfo=#{lininfo}"

          lininfo2=lininfo.to_s.gsub(/<span>.*+<\/span>/,"  ")

        logger.info lininfo2

         # to_name= lininfo.match(/<\/span>.*<\/a>/).to_s.gsub("</span>","").gsub("</a>","")
        #  from_name=full_line_text.gsub(to_name,"")

         # logger.info "lineinfo=#{lininfo}"
           #   logger.info "lineinfo=#{lininfo[0]}"
          #        logger.info "lineinfo=#{lininfo[2]}"
         # divided1=lininfo.to_s.split()
        #  from_name=  lininfo.match(/\<a\>.*\<span\>/)
         # to_name= lininfo.match(/<\/span>.*<\/a>/)
         # logger.info "from=#{from_name},to_name=#{to_name}"
        #  to_name= lininfo.to_s.gsub(from_name,"").gsub("：","").gsub("-","").gsub("  ","").to_s
        #  from_name=from_name.gsub("起运地","").gsub("目的地","").gsub("：","").gsub("-","").gsub("  ","").to_s

          cargo[:fcity_name]=from_name
          cargo[:tcity_name]=to_name
          city_array=city_parse(cargo[:fcity_name],cargo[:tcity_name])
          cargo[:fcity_code]=city_array[0]; cargo[:tcity_code]=city_array[1]; cargo[:line]=city_array[2]
           cargo[:fcity_name]=get_city_full_name(cargo[:fcity_code]) unless cargo[:fcity_code].nil?
           cargo[:tcity_name]=get_city_full_name(cargo[:tcity_code]) unless cargo[:tcity_code].nil? 
      
          packinfo=entrycontainer.css("div.c_line").text.match(/货品属性.*$/u).to_s
          raw_array0= packinfo.match(/货品属性：.*重量：/u).to_s.gsub("货品属性：","").gsub("重量：","").to_s      
          raw_array3= packinfo.match(/重量：.* 吨/u).to_s.gsub("重量：","").gsub("吨","").to_s
          raw_array5= entrycontainer.css("div.c_name").text.match(/^.*交易状态/u).to_s.gsub("交易状态","").to_s

          raw_array6= entrycontainer.css("div.c_main_r").text
          raw_array7 =entrycontainer.css("div.c_btm").text.to_s
     
          cargo[:contact]=raw_array6
          cargo[:comments]=raw_array5.to_s+raw_array6.to_s+raw_array7.to_s
          cargo[:mobilephone]=cargo[:comments].match(/1\d\d\d\d\d\d\d\d\d\d/).to_s
          cargo[:fixphone]=cargo[:comments].match(/\d\d\d+-\d\d\d\d\d\d\d+/).to_s 
          cargo[:cargo_weight]=raw_array3
          cargo[:cate_name]=raw_array5
          cargo[:send_date]=1
          cargo[:from_site]="56135"
          cargo[:created_at]=Time.now
          cargo[:status]="正在配车"  # for match local
          cargo[:priority]=500
          cargo[:user_id]="4e24c1d47516fd513c000002" #admin id
          all_raw_cargo<<cargo unless cargo.blank?
        end
      end
    end

    return  all_raw_cargo
end