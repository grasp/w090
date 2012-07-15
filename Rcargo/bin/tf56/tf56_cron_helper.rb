#coding:utf-8

#some lib depends on cron init  or main to load

def tf56_cargo_cron(logger)
    logger.info "one cycle started on #{Time.now}!"  

    mechanize=Mechanize.new  
    mechanizeb=Mechanize.new
    @all_raw_cargo=Array.new    
    (7..16).include?(Time.now.hour) ? @page_count=5 : @page_count=1  #in busy time ,we need fetch more page  
    logger.info "page count=#{@page_count}"

    @page_count.downto(1).each do |i| #each time we parse 3 page

     page = mechanize.post("http://www.tf56.com/wshy.asp",{:me_page=>i}) #fetch the page,we get internal url by firefox firebug always,firefox may need latest version like version 8
    
      page.parser().css("html body table table table table table tr td.hydash:first").each do |cargo_row|  #parser convert page into nokogiri object  
        cargo_link=cargo_row.css("a").map { |link| link['href'] }  # this solution stole from internet stackover-flow question
        cargo_link=cargo_link[0]

        logger.info "handle cargo_link=#{cargo_link}"


      # change blank? to nil? get below code work, very strange behavior
        if cargo_link.nil? #ignore those unexisited link 
           logger.info "your got a empty cargo link,nothing will grasped for this page!!!"
           next 
        end
          
          mechanizeb.get("http://www.tf56.com/"+cargo_link) do |page|  #cargo information are all in page after open this link

          one_cargo=Hash.new
          parsed= page.parser.css("html body table table table table table table tr td.hytitle") #mannully map all information to ours
          one_cargo[:name]=parsed[1].content unless parsed[1].nil? 
          logger.info "raw cate_name=#{one_cargo[:name]}"

          one_cargo[:weight]=parsed[2].content   unless parsed[2].nil?
          logger.info "raw cargo weight=#{one_cargo[:cargo]}"

          one_cargo[:fcityn]=parsed[3].content unless parsed[3].nil?  
          logger.info "raw fcityname=#{one_cargo[:fcityn]}"

          one_cargo[:tcityn]=parsed[4].content  unless parsed[4].nil?
          logger.info "raw tcityname=#{one_cargo[:tcityn]}"


          unless parsed[5].nil?
            unless parsed[5].content.nil?
              one_cargo[:comments]="车辆要求:"+ parsed[5].content 
            else
              one_cargo[:comments]="车辆要求:"+ "未说明";
            end             
          else
            one_cargo[:comments]="车辆要求:"+ "未说明";
          end

          logger.info "raw comments=#{one_cargo[:comments]}"
          
          one_cargo[:contact]=parsed[6].content unless parsed[6].nil?    
          logger.info "raw contact=#{one_cargo[:contact]}"

          one_cargo[:timetag]=parsed[7].content unless parsed[7].nil?    
          logger.info "raw timetag=#{one_cargo[:timetag]}"
           
          city_array=city_parse(one_cargo[:fcityn],one_cargo[:tcityn])
        
          one_cargo[:fcityc]=city_array[0]; one_cargo[:tcityc]=city_array[1]; one_cargo[:line]=city_array[2]
          logger.info "raw tcity_code=#{one_cargo[:tcityc]}"
          logger.info "raw fcity_code=#{one_cargo[:fcityc]}"

          one_cargo[:created_at]=Time.now;   one_cargo[:expire]=1           
          one_cargo[:fsite]="tf56";   one_cargo[:priority]=200
          one_cargo[:ruser_user_id]="4e24c1d47516fd513c000002" #admin id, is this correct after import ruser module?
          one_cargo[:status]="正在配车"  # for match local

          #we need got fix phone and mphone infomation, this for statistic how many cargo been published by one phone
          unless one_cargo[:contact].nil?
            if one_cargo[:contact].match(/\[\d+\]/)
              one_cargo[:fphone]= one_cargo[:contact].match(/\[\d+\]/).to_s.gsub("[","").gsub("]","").to_s+"-"+one_cargo[:contact].match(/\d\d\d\d\d\d\d\d/).to_s
            end
            if one_cargo[:contact].match(/\d\d\d\d\d\d\d\d\d\d\d/)
              one_cargo[:mphone]= one_cargo[:contact].match(/\d\d\d\d\d\d\d\d\d\d\d/).to_s
            end
          end

          if one_cargo[:mphone].nil? #try comments , sometimes phone is in comments
            one_cargo[:mphone]=one_cargo[:comments].match(/\d\d\d\d\d\d\d\d\d\d\d/).to_s
          end

          @all_raw_cargo<<one_cargo if  one_cargo.length>0   #at least something is there

        end

      end
    end
    return @all_raw_cargo
end