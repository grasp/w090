#coding:utf-8
#require 'active_support'

def quzhou_cargo_cron(logger)

     logger.info "quzhou_cargo_helper"
     mechanize=Mechanize.new  

	 all_raw_cargo=Array.new 
     (7..16).include?(Time.now.hour) ? @page_count=5 : @page_count=1  #in busy time ,we need fetch more page     
     @page_count.downto(1) do |i|
      mechanize.get("http://56.qz56.com:8081/wl/UserQueryData.jsp?offset=#{i}&likestr=") do |page|      
        page.parser().css("html body div table tbody tr td table tr").each do |tr|
         # logger.info "start a new cargo"
          one_cargo=Hash.new
          one_item_array=Array.new
          tr.css("td").each do |td|
            one_item_array<<td.content     
          end  

           one_item_array.each_index do |i|
            logger.info "index#{i}= #{one_item_array[i]}"
          end         

         unless one_item_array[0].nil?
            if one_item_array[0].match("货物")#marked as cargo

              one_cargo[:name]=(one_item_array[1]||"未知货物").strip  
     
              one_cargo[:name]="货物未知" if one_cargo[:name].nil?

              one_cargo[:fcityn]=(one_item_array[2]||"未知城市").strip
              one_cargo[:tcityn]=(one_item_array[3]||"未知城市").strip


              city_array=city_parse(one_cargo[:fcityn],one_cargo[:tcityn])
              one_cargo[:fcityc]=city_array[0];
              one_cargo[:tcityc]=city_array[1]; one_cargo[:line]=city_array[2]
              logger.info "one_cargo[:fcityc]=#{one_cargo[:fcityc]}"
              logger.info "one_cargo[:tcityc]=#{one_cargo[:tcityc]}"

              one_cargo[:fcityn]=get_city_full_name(one_cargo[:fcityc]) unless one_cargo[:fcityc].nil?
              one_cargo[:tcityn]=get_city_full_name(one_cargo[:tcityc]) unless one_cargo[:tcityc].nil? 
              one_cargo[:fcityn]=one_item_array[2]||"未知城市" if one_cargo[:fcityn].nil?
              one_cargo[:tcityn]=one_item_array[3]||"未知城市" if one_cargo[:tcityn].nil?

              logger.info "one_cargo[:fcityn]=#{one_cargo[:fcityn]}"
              logger.info "one_cargo[:tcityn]=#{one_cargo[:tcityn]}"

              one_cargo[:weight]=(one_item_array[4]||"0").strip+(one_item_array[5]||"").strip
              one_cargo[:price]=(one_item_array[6]||"0").strip+(one_item_array[7]||"").strip
              one_cargo[:comments] = "车辆要求"+(one_item_array[8]||"0").strip+(one_item_array[9]||"").strip
              one_cargo[:mphone]=one_item_array[11].strip.match(/1\d\d\d\d\d\d\d\d\d\d/).to_s
              one_cargo[:fphone]=one_item_array[11].strip.match(/^\d\d\d\d\d\d\d$/).to_s 

              if one_cargo[:fphone].size>0
                one_cargo[:fphone]="0570-"+one_cargo[:fphone]
              end  

              one_cargo[:contact] = (one_item_array[10]||"").strip+"-电话"+(one_cargo[:fphone]||"")+one_cargo[:mphone]              
              one_cargo[:timetag] = (one_item_array[12]||"").strip
              one_cargo[:expire]=1
              one_cargo[:from_site]="quzhou"
              one_cargo[:created_at]=Time.now
              one_cargo[:status]="正在配车"  # for match local
              one_cargo[:priority]=600 #not use for now
              one_cargo[:ruser_user_id]="4e24c1d47516fd513c000002" #admin id

  
              all_raw_cargo<<one_cargo if one_cargo.length>0
            
            end       
          end
             
        end
      end
    return  all_raw_cargo
end