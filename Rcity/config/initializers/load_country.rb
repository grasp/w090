

Rcity::Country.create!(:code=>"086",:name=>"中国")  unless Rcity::Country.where(:code=>"086").first