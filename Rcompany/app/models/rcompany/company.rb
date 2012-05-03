 # coding: utf-8
module Rcompany
class Company 
   include Mongoid::Document
   include Mongoid::Timestamps
 
     field :name, :type=>String
     field :about, :type=>String
     field :selfche, :type=>Integer
     field :signedche, :type=>Integer
     field :numemploy, :type=>Integer
     field :contacter, :type=>String
     field :cityn, :type=>String
     field :cityc, :type=>String
     field :address, :type=>String 
     field :quhao, :type=>String
     field :fphone, :type=>String
     field :mphone, :type=>String
     field :email, :type=>String    
     field :ispersonal, :type=>String
     field :ctype, :type=>Integer
     belongs_to :user,:class_name=>"Ruser::User"
      
     validates_uniqueness_of :name ,:message=>"该公司名字已经被注册."
     validates_uniqueness_of :email ,:message=>"该Email所属公司已经被注册."
end
end
