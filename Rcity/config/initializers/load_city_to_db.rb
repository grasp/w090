#coding:utf-8

require File.join(File.dirname(__FILE__),"load_country.rb")


def load_province_into_db
    @current_country=Rcity::Country.where(:code=>"086").first
    raise unless @current_country
    #first write into all province name
    filename=File.dirname(__FILE__)+File::SEPARATOR+"code3.txt"
    open(filename).each do |line|
      line=Iconv.conv("utf-8//IGNORE","GB2312",line)
      name= line.split(',')
      name[1]=name[1].chomp!
      if name[0].match(/\d\d0000000000$/) # is a province id
        province=@current_country.provinces.build(:code=>name[0],:name=>name[1])
        province.save!
        #   $province_region[name[0]]=name[1]  #insert name hash at first when found a province
        #   $citytree[name[0]]={}
        #   $province_tree[name[0]]=Array.new

      elsif name[0].match(/\d\d\d\d00000000$/)  and (not name[0].match(/\d\d0000000000$/))  # is a region
        # $province_region[name[0]]=name[1]  #insert name hash at first when found a region
        # province_code=name[0].slice(0,2)+"0000000000"
        #$citytree[province_code][name[0]]={}
        #$province_tree[province_code]=$province_tree[province_code]<< name[0]
        #$all_region_hash[name[1]]=name[0]
        #$region_code[name[0]]=[]

      elsif (not name[0].match(/\d\d\d\d00000000$/)) and (not name[0].match(/\d\d0000000000$/))# is a city
        #province_code=name[0].slice(0,2)+"0000000000"
        #region_code=name[0].slice(0,4)+"00000000"
        #$citytree[province_code][region_code][name[0]]=name[1]
        #$region_code[region_code]<< name[0]

      else
        puts "非法城市数据"
      end
    end
  end
Rcity::Province.delete_all
load_province_into_db
