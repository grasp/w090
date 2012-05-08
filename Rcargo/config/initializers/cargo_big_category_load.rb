#coding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.

if false
def load_cargo_big_category
    $cargo_big_category=Hash.new
     filename=File.dirname(__FILE__)+File::SEPARATOR+"cargo_big_category.txt"
      open(filename).each do |line|
        if line.size >0
          user=line.force_encoding("utf-8").split(/\s/)
          $cargo_big_category[user[0]]=user[1].force_encoding("utf-8")
          next if user[0].nil?
          code=user[0].strip
          name=user[1].force_encoding("utf-8").strip
          Rcargo::CargoBigCategory.create!(:code=>user[0],:name=>user[1].force_encoding("utf-8"))
          $cargo_big_category[code]=name
        end
    end
  end

def load_cargo_big_category_into_db
        $cargo_big_category=Hash.new
     filename=File.dirname(__FILE__)+File::SEPARATOR+"cargo_big_category.txt"
      open(filename).each do |line|
        if line.size >0
          user=line.force_encoding("utf-8").split(/\s/)
          $cargo_big_category[user[0]]=user[1].force_encoding("utf-8")
          next if user[0].nil?
          code=user[0].strip
          name=user[1].force_encoding("utf-8").strip
          Rcargo::CargoBigCategory.create!(:code=>user[0],:name=>user[1].force_encoding("utf-8"))
          $cargo_big_category[code]=name
        end
    end
end

#load_cargo_big_category
#Rcargo::CargoBigCategory.delete_all
load_cargo_big_category_into_db if Rcargo::CargoBigCategory.count==0
#$cargo_big_category.each do |key,value|
  
 # puts "cargo_big_category：#{key}=#{value}"
#end

end