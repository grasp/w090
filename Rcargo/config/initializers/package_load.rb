# coding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'iconv'

$KCODE="U"
$package_category_one=Hash.new
$package_category_two=Hash.new
$packagetree=Hash.new
if false
  def load_package_category_to_hash
  filename=File.dirname(__FILE__)+File::SEPARATOR+"package_category.txt"
  open(filename).each do |line|
    line=line.force_encoding("utf-8")
    if not line.nil?
    #  puts "line=#{line}"
      code= line.match(/^\d\w+/)
      if not code.nil?
        code=code.to_s
        code.chomp!
        code.strip!
        #puts "code=#{code}"
        #notes , the last line need a enter
        name=line.match(/\W+/)
        name=name.to_s
        name.chomp!
        name.strip!

     if code.match(/\d000/)  # if first level
       $package_category_one[code]=name  #to find name for first level
       $packagetree[code]={}
     else
       parent_code=code[0]+"000"
       $packagetree[parent_code][code]=name
     end  
     
        $package_category_two[code]=name
      end
    end
  end
end
end


def load_package_into_db
  $cargo_package=Hash.new
  filename=File.dirname(__FILE__)+File::SEPARATOR+"package_category2.txt"
  open(filename).each do |line|
    line=line.force_encoding("utf-8")
      next if line.nil?
      code= line.match(/^\d\w+/)
      next if code.nil?
      name=line.match(/\W+/)
      next if name.nil?      
      $cargo_package[code.to_s.strip]=name.to_s.strip
      Rcargo::CargoPackage.create!(:code=>code.to_s.strip,:name=>name.to_s.strip)    
  end
end

def load_package_from_db_into_hash
   $cargo_package=Hash.new
    Rcargo::CargoPackage.all.each do |package|
      next if package.code.nil?
      $cargo_package[package.code]=package.name
    end
end

load_package_into_db if Rcargo::CargoPackage.count==0
load_package_from_db_into_hash
#load_package_category_to_hash
#$packagetree.freeze
#$package_category_one.freeze





