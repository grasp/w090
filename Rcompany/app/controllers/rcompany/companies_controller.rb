# coding: utf-8
module Rcompany
class CompaniesController < Rcompany::ApplicationController
  # GET /companies
  # GET /companies.xml
 before_filter:require_user,:except => [:yellowpage,:show,:search]

 # before_filter:admin_authorize,:only=>[:index] #for debug purpose
 # before_filter:authorize,:except => [:yellowpage,:show,:search]
  #protect_from_forgery :except => [:tip,:login,:search]

  include Rcompany::CompaniesHelper
  #include CitiesHelper
  layout :choose_layout
  
  def choose_layout
    return 'rtheme/rcompany'
    #return 'admin'  if action_name =='admin'      
   # return nil  if action_name =='publiccenter'     
   # return 'company' if  action_name=="yellowpage"
   # return 'usercenter' if action_name=="privatecenter" ||action_name=="new" || action_name=="edit"
   # return  'company'
  end
     
  def admin
    @companies = Company.paginate(:page=>params[:page]||1,:per_page=>20)
  end
  
  def yellowpage
   @companies = Company.desc(:created_at).limit(200).paginate(:page=>params[:page]||1,:per_page=>25)
   @companies=@companies.to_a
  end
  
  def index
   @companies=current_user.company

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end  
  

  # GET /companies/new
  # GET /companies/new.xml
  def new
      
    params[:cheng_id]="330100000000" if params[:cheng_id].nil?
    @country=Rcity::Country.where(:code=>"086").first#hard code
    @provinces=@country.provinces.asc(:code).to_a    
    @province=Rcity::Province.where(:code=>params[:cheng_id].slice(0,2)+"0000000000").first
    @regions=@province.regions 
    @match_province=params[:cheng_id].slice(0,2)+"0000000000"
    @match_region=params[:cheng_id].slice(0,4)+"00000000"
    @match_cheng=params[:cheng_id].slice(0,6)+"000000"  
    
    #@company=current_user.company.new
    @company=Company.new
    
    respond_to do |format|
    format.html # new.html.erb 
    #format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    params[:cheng_id]="330100000000" if params[:cheng_id].nil?
    @country=Rcity::Country.where(:code=>"086").first#hard code
    @provinces=@country.provinces.asc(:code).to_a    
    @province=Rcity::Province.where(:code=>params[:cheng_id].slice(0,2)+"0000000000").first
    @regions=@province.regions 
    @match_province=params[:cheng_id].slice(0,2)+"0000000000"
    @match_region=params[:cheng_id].slice(0,4)+"00000000"
    @match_cheng=params[:cheng_id].slice(0,6)+"000000"

    @company=Company.find(params[:id])

  end

  # POST /companies
  # POST /companies.xml
  def create
    @company = current_user.build_company(params[:company])

    respond_to do |format|
      if @company.save
        expire_fragment "yellowpage"
        expire_fragment "users_center_#{session[:user_id]}"
        flash[:notice] = '公司成功创建，恭喜你创建完成了!'
        format.html {  redirect_to :action=>"show",:id=>@company.id}
      else
        flash[:notice] = '公司创建失败了,再次创建试试看？'
        format.html {  redirect_to :action=>"new"}
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    #params[:company][:fix_phone]=params[:quhao]+"-"+ params[:company][:fix_phone]
    @company= Company.find(params[:id])
    #company = update_company(params)
   # expire_fragment "users_center_#{session[:user_id]}"
    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:notice] = "公司信息成功更新"
         format.html { redirect_to(@company) }
         #format.html {  redirect_to :action=>"privatecenter"}
        format.xml  { head :ok }
      else
        flash[:notice] << " 公司信息更新失败"
        format.html { redirect_to :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def search    
    puts params
    puts "paramssearch#{params[:companysearch]}"
    @company=Company.new
    @company.city_code=params[:companysearch][:city_code]
    @company.city_name=params[:companysearch][:city_name]
    begin
    @search_city=get_city_full_name(params[:companysearch][:city_code]) #city code is nil   
    rescue
      @search_city=nil
    #  puts "search city code=#{params[:companysearch][:city_code]}"
     #     respond_to do |format|
     #        format.html { render :action=>"yellowpage" }
    #      end
     #     return
    end
    
      @companies=get_search_companies(params[:companysearch][:city_code])
   
    respond_to do |format|
      format.html 
      format.xml 
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    respond_to do |format|
      format.html { redirect_to(admincompany_manage_url) }
      format.xml  { head :ok }
    end
  end
  
  def publiccenter
    
      @company=Company.find(params[:id]) #only one company actull
  end
  
  def privatecenter  
    #we have to use username 
   @company=Company.where(:user_id =>session[:user_id].to_s).first #only one company actull
   @company=Company.new if @company.blank?
   
     @search_city="city name is not blank" if @company.city_name.blank?
   @search_city="请选择城市"
    respond_to do |format|
      format.html { render :action=>"show" }
      format.xml  { head :ok }
    end
  end
end
end
