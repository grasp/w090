# coding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'iconv'

$KCODE="U"
   
  $cargo_category_one=Hash.new
  $cargo_category_two=Hash.new
#  $cargo_category_three=Hash.new
  $catename=Hash.new
  $catetree=Hash.new

def load_cargo_category_to_hash
  filename=File.dirname(__FILE__)+File::SEPARATOR+"cargo_category.txt"
  open(filename).each do |line|
  line=line.force_encoding("utf-8")
# line=line.chomp!
#  line=Iconv.conv("utf-8","GBK",line)
  code= line.match(/\d+/)
  code=code.to_s
  #notes , the last line need a enter
  name=line.match(/\s.*\n/)
  name=name.to_s.chomp!
  unless code.nil?
 # $cargo_category.store(code,name) 
   if (code.match(/\d\d0000/))
     $cargo_category_one[code]=name
     $catename[code]=name
     $catetree[code]={}
     
   elsif(code.match(/\d\d\d\d00/))
     parent_code=code[0,2]+"0000"  
     $catename[code]=name
     $catetree[parent_code][code]={}
  else
     parent_code=code[0,4]+"00"
     ancient_code=code[0,2]+"0000"
     $catetree[ancient_code][parent_code][code]=name
   end
   $cargo_category_two[code]=name
  
  end 

  end
end




def load_cargo_category_into_db
filename=File.dirname(__FILE__)+File::SEPARATOR+"cargo_category2.txt"
  open(filename).each do |line|
  line=line.force_encoding("utf-8")
# line=line.chomp!
#  line=Iconv.conv("utf-8","GBK",line)
  next if line.nil?
  code=line.match(/\d+/)
  code=code.to_s
  next if code.nil?
  #notes , the last line need a enter
  name=line.match(/\s.*\n/)
  name=name.to_s.chomp!
   next if name.nil?
  unless code.nil?
 # $cargo_category.store(code,name) 
  if (code.match(/\d\d0000/))
    Rcargo::CargoBigCategory.create!(:code=>code.strip,:name=>name.strip)
  else
    big_category=Rcargo::CargoBigCategory.where(:code=>code.slice(0,2)+"0000").first

    #    puts code 
  raise  if big_category.nil?
    puts
    #if  big_category.nil?
   #    big_category=Rcargo::CargoBigCategory.create!(:code=>code.slice(0,2)+"0000")
  #  end   
    big_category.categories.create!(:code=>code.strip,:name=>name.strip)  
  end 
  end

end
end

def load_big_category_into_hash_from_db 
  $big_cate_hash=Hash.new
   Rcargo::CargoBigCategory.all.each do |big_cate|
    $big_cate_hash[big_cate.code]=big_cate.name
   end
end

load_cargo_category_to_hash

#Rcargo::CargoBigCategory.delete_all
#Rcargo::CargoCategory.delete_all
load_cargo_category_into_db if Rcargo::CargoCategory.count==0
load_big_category_into_hash_from_db 