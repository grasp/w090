require 'rubygems'
require 'pathname'


pn = Pathname.new(File.dirname(__FILE__))
project_root=pn.parent.parent # w090 folder

#some sequence for load,otherwise load will fail as some file depends on others
require File.join(project_root,"Rcity","config","initializers","city_dic.rb")
require File.join(project_root,"Rcity","config","initializers","city_load.rb")
require File.join(project_root,"Rcity","app","helpers","rcity","chengs_helper.rb")
require File.join(project_root,"Rcargo","app","helpers","rcargo","cargos_helper.rb")
require File.join(project_root,"Rcargo","app","models","rcargo","cargo.rb")
