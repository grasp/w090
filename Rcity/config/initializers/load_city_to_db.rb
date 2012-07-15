#coding:utf-8

require File.join(File.dirname(__FILE__),"load_country.rb")


def get_current_object_by_code(class_name,code)
   current_object=class_name.where(:code=>"#{code}").first
   current_object.nil? ? (raise unless current_object):current_object
end

def get_city_code_file_full_path(filename)
  filename=File.dirname(__FILE__)+File::SEPARATOR+"#{filename}"
end


def scan_code_name_for_cn
    current_country= get_current_object_by_code(Rcity::Country,"086")   
    open(get_city_code_file_full_path("code3.txt")).each do |line|
      line=Iconv.conv("utf-8//IGNORE","GB2312",line)
      name= line.split(',')
      city_code=name[0]
      city_name=name[1].chomp!
      yield current_country,city_code,city_name
    end
end

def load_province_into_db_for_cn
    scan_code_name_for_cn  do |current_country,city_code,city_name|
      if city_code.match(/\d\d0000000000$/)  # is a province id
        current_country.provinces.create!(:code=>city_code,:name=>city_name)
      end
    end
end

def load_regions_into_db_for_cn
    scan_code_name_for_cn  do |current_country,city_code,city_name|
      if city_code.match(/\d\d\d\d00000000$/) and !city_code.match(/\d\d0000000000$/)   # is a region id
        begin
        current_province= get_current_object_by_code(Rcity::Province,city_code.slice(0,2)+"0000000000")
        rescue
          puts "call load_province_into_db_for_cn at first!!!"
        end
        current_province.regions.create!(:code=>city_code,:name=>city_name)
      end
    end
end

def load_cities_into_db_for_cn
    scan_code_name_for_cn  do |current_country,city_code,city_name|
      if city_code.match(/\d\d\d\d\d\d000000$/) and not city_code.match(/\d\d\d\d00000000$/) and not city_code.match(/\d\d0000000000$/)   # is a region id
        begin
        #diff country city must have diff code,otherwise will fail,validate unique make this
        current_region= get_current_object_by_code(Rcity::Region,city_code.slice(0,4)+"00000000") 
        rescue
          puts "call load_regions_into_db_for_cn at first!!!"
        end
        current_region.chengs.create!(:code=>city_code,:name=>city_name)
      end
    end
end


#Rcity::Province.delete_all
#Rcity::Region.delete_all
#Rcity::Cheng.delete_all
load_province_into_db_for_cn if Rcity::Province.count==0
load_regions_into_db_for_cn  if Rcity::Region.count==0
load_cities_into_db_for_cn   if Rcity::Cheng.count==0

