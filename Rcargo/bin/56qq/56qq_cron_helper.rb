#coding:utf-8
def qq56_cargo_cron(logger)
    logger.info "start to run qq56_cargo_cron"

    mechanize=Mechanize.new  
    all_raw_cargo=Array.new 
    #cid	-1 fs	30 pid	11
    pid_list=[11,12,13,15,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,41,42,43,51,52,53,54,61,62,63,64,65]      
 # pid_list=[11]      
    mechanize.cookies.each do |cookie|  #56qq use javascript to write pid into cookie to judge which province or city user want to view,so we have to do by ourself
      if cookie.domain=="www.56qq.cn"
          logger.info   cookie.name
          logger.info   cookie.value
      end
    end
     

    mechanize.get("http://www.56qq.cn/#msgboard/list/c") #do |page|  #for generate a history, so setcookie will not raise history empty exception
   # end    
  
    pid_list.each do |pid|
      logger.info "testpoint 1" 
      begin
        mechanize.cookie_jar.add("www.56qq.cn","pid",pid)
        mechanize.cookie_jar.add("www.56qq.cn","cid",-1)  
      rescue
        logger.info $@
      end
      logger.info "testpoint 2"
      mechanize.get("http://www.56qq.cn") 

    
     city_list= mechanize.get("http://www.56qq.cn/pagelet/common/regions?v=20110513").body
     @flatter_city=Hash.new
    
     parsed_citylist = ActiveSupport::JSON.decode( city_list)
      parsed_citylist.each do |province|      
        @flatter_city[province["id"].to_s]=province["name"]
       province["children"].each do |region|
          @flatter_city[region["id"].to_s]=region["name"]
          region["children"].each do |city|
           #  logger.info city["id"].to_s+"#{city["name"]}"
             @flatter_city[city["id"].to_s]=city["name"]
          end
       end
      end
           logger.info "testpoint 3"
     # logger.info @flatter_city
   result=  mechanize.get("http://www.5qqq.cn/logistics/message/query?pid=#{pid}&t=C&fs=30") 

 parsed_huo = ActiveSupport::JSON.decode(result.body)
 logger.info "testpoint 4"
 parsed_huo["content"]["msgs"].each do |onecargo|
  #  logger.info onecargo
    from_city=onecargo["dep"].to_s.split(",")
    to_city=onecargo["dest"].split(",")
   #  logger.info from_city.to_s+"to"+to_city.to_s
      #  logger.info onecargo["dep"].to_s+"#{onecargo['dest']}"
    from_city.each_index do |index|
      from_city[index]=  @flatter_city[from_city[index]]
    #  logger.info from_city[index].to_s+"#{@flatter_city[from_city[index]]}"
    end
       to_city.each_index do |index|
      to_city[index]=  @flatter_city[to_city[index]]
     #  logger.info to_city[index].to_s+"#{@flatter_city[to_city[index]]}"
    end
#logger.info from_city
#logger.info to_city
#if false
logger.info "testpoint 5"
          parse_56qq_line(from_city,to_city).each do |line|
          #  if raw_array[1].match("货源信息")
            #  onecargo=[line,raw_array[1], raw_array[2]]
                if !line[0].nil? and !line[1].nil?
                one_cargo=Hash.new 
                one_cargo[:fcity_code]=line[0]
                one_cargo[:tcity_code]=line[1]
                one_cargo[:line]=(one_cargo[:fcity_code]||"")+"#"+(one_cargo[:tcity_code]||"")
                one_cargo[:fcity_name]=get_city_full_name(one_cargo[:fcity_code]) unless one_cargo[:fcity_code].nil?
                one_cargo[:tcity_name]=get_city_full_name(one_cargo[:tcity_code]) unless one_cargo[:tcity_code].nil? 
                #   logger.info "#{cargo[:fcity_name]}-#{cargo[:tcity_name]}"
                #cargo[:comments]=onecargo[1].gsub(/货源信息：/,"").gsub(/备注内容：/,"").gsub(/联系我时，请说是在56QQ上看到的，谢谢！/,"").gsub(/\s/,"")
              one_cargo[:comments]= onecargo["c"]
              one_cargo[:cargo_weight]=one_cargo[:comments].match(/\d\d\d吨|\d\d吨|\d吨|\d方|\d\d方/).to_s
                one_cargo[:cate_name]=one_cargo[:comments].to_s[-10..-1]
               # cargo[:contact]=onecargo[2].gsub(/TEL\:/,"") 
              one_cargo[:contact]=onecargo["m"] ||""+onecargo["tel"] ||""
                #fetch mobilephone and fixphone
                one_cargo[:mobilephone]=one_cargo[:contact].match(/1\d\d\d\d\d\d\d\d\d\d/).to_s
                one_cargo[:fixphone]=one_cargo[:contact].match(/\d\d\d+-\d\d\d\d\d\d\d+/).to_s  
                one_cargo[:send_date]=1
               one_cargo[:from_site]="56qq"
                one_cargo[:created_at]=Time.now
               one_cargo[:status]="正在配车"  # for match local
                one_cargo[:priority]=300
               one_cargo[:timetag]=Time.now # which time it is generated
               # a=Time.now
               # if timetag.match("上午")||timetag.match("下午")
               #   cargo[:timetag]=a.month.to_s+"月"+a.day.to_s+"日"+timetag                                
              #  end
             #   if timetag.match("昨天")
               #   a=a-86400
                #  cargo[:timetag]=a.month.to_s+"月"+a.day.to_s+"日"+timetag.delete("昨天")                                
               # end
               logger.info "testpoint 5"
               one_cargo[:user_id]="4e24c1d47516fd513c000002" #admin id
                if  one_cargo.length>0   #at least something is there              
                all_raw_cargo<<one_cargo
              #  logger.info cargo
               # puts "cargo =#{cargo}"
              end
             #   end
             # end
            end
        end
      end
    end   
   # save_cargo(all_raw_cargo)
  end
  