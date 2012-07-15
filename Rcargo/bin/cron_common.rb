  #all raw cargo is a interpreted cargo array for store into database

include  Rcity::ChengsHelper  #depends on cron init to load file at first

def city_parse(from_city,to_city)
    city_array=Array.new
    city_array[0]=CityTree.get_code_from_name(from_city) unless from_city.nil?
    city_array[1]=CityTree.get_code_from_name(to_city) unless to_city.nil?
    city_array[2]=(city_array[0]||"")+"#"+(city_array[1]||"")
    
    #change to our name
    city_array[3]=get_city_full_name(city_array[0]) unless city_array[0].nil?
    city_array[4]=get_city_full_name(city_array[1]) unless city_array[1].nil?
    # we need store those unknow city, try recognize them by mannual
    [city_array[0],city_array[1],city_array[2],city_array[3],city_array[4]]      
end

def set_cookie(mechanize,domain,name,value)
    cookie = Mechanize::Cookie.new(name, value)
    cookie.domain = domain
    cookie.path = "/"
    mechanize.cookie_jar.add(@mechanize.history.last.uri,cookie) #we have to run get before we set cookie ,otherwise will have nil error
    return mechanize
end

def save_cargo(all_raw_cargo,logger)
 #!!!!! for debug
   Rcargo::Cargo.delete_all

   total=all_raw_cargo.size unless  all_raw_cargo.nil?
   fail=0

    all_raw_cargo.each do |cargo|
      begin
        if cargo[:name].size >15
          cargo[:name]=cargo[:cate][0,14]
        end
       Rcargo::Cargo.create!(cargo)
      rescue
      
      fail+=1
      end
    end

     logger.info "fail=#{fail}/#{total} "
end 