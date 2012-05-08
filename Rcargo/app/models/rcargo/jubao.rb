class Rcargo::Jubao
  #jubao type
  field :jtype
  field :comments
  field :jmphone # bei jubao dianhua   mobile phone
  field :jfhone  # bei jubao dianhua fix phone
  belongs_to :juser,:class_name=>"Ruser::User"  # bei jubao ren
  belongs_to :jcompany,:class_name=>"RCompany::Company"  #  bei jubao gongsi
  belongs_to :user,:class_name=>"Ruser::User"  #  jubao ren
  belongs_to :cargo,:class_name=>"Rcargo::Cargo"
 
end