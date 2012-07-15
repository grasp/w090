#coding:utf-8
#"chinese input is no work"
Rcity::Country.create!(:code=>"086",:name=>"中国")  if Rcity::Country.where(:code=>"086").first.nil?
