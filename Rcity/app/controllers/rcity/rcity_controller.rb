#coding: utf-8
class Rcity::RcityController < ApplicationController
  layout "rtheme/rcity"

  def line_select_common
    	 params[:cheng_id]="330100000000" if params[:cheng_id].nil?
        @country=Rcity::Country.where(:code=>"086").first#hard code
        @provinces=@country.provinces.asc(:code).to_a    
        @province=Rcity::Province.where(:code=>params[:cheng_id].slice(0,2)+"0000000000").first
        @regions=@province.regions 
        @match_province=params[:cheng_id].slice(0,2)+"0000000000"
        @match_region=params[:cheng_id].slice(0,4)+"00000000"
        @match_cheng=params[:cheng_id].slice(0,6)+"000000"
  end
end
