# coding: utf-8
module Rcompany
class CompaniesController < Rcompany::ApplicationController
  # GET /companies
  # GET /companies.xml
 before_filter:require_user,:except => [:yellowpage,:show,:search]
 before_filter :init_base_breadcrumb

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
  
  def search
   drop_breadcrumb(t("companycommon.yellowpage"))
   @companies = Company.desc(:created_at).paginate(:page=>params[:page]||1,:per_page=>25)
  # @companies=@companies.to_a
    set_seo_meta(t("companycommon.yellowpage"),"#{Setting.app_name}#{t("companycommon.yellowpage")}")
  end

   def search_province
      next_province=params[:province_id].to_i+10000000000
      @companies = Company.where(:cityc.gte=>params[:province_id].to_s,:cityc.lt=> next_province.to_s).desc(:created_at)
      .paginate(:page=>params[:page]||1,:per_page=>25)      
      @province=Rcity::Province.where(:code=>params[:province_id]).first      
      @region_list=@province.regions
      drop_breadcrumb(t("companycommon.yellowpage"))
      set_seo_meta("#{@province.name}"+t("companycommon.yellowpage"),"#{Setting.app_name}#{t("companycommon.yellowpage")}")
  end


  def search_region
      drop_breadcrumb(t("companycommon.yellowpage"))

      @province=Rcity::Province.where(:code=>params[:region_id].slice(0,2)+"0000000000").first
      @region=Rcity::Region.where(:code=>params[:region_id].slice(0,4)+"00000000").first
      @city_list=@region.chengs
      @region_list=@province.regions
      next_region=params[:region_id].to_i+100000000 
      @companies = Company.where(:cityc.gte=>params[:region_id].to_s,:cityc.lt=> next_region.to_s).desc(:created_at)
      .paginate(:page=>params[:page]||1,:per_page=>25)
      set_seo_meta("#{@province.name}#{@region.name}"+t("companycommon.yellowpage"),"#{Setting.app_name}#{t("companycommon.yellowpage")}")
  end

  def search_cheng
      @province=Rcity::Province.where(:code=>params[:cheng_id].slice(0,2)+"0000000000").first
      @region=Rcity::Region.where(:code=>params[:cheng_id].slice(0,4)+"00000000").first
      @cheng=Rcity::Cheng.where(:code=>params[:cheng_id]).first
      @city_list=@region.chengs
      @region_list=@province.regions  
      @companies = Company.any_of(:cityc=>params[:cheng_id].to_s).desc(:created_at)
      .paginate(:page=>params[:page]||1,:per_page=>25)
       set_seo_meta("#{@region.name}#{@cheng.name}"+t("companycommon.yellowpage"),"#{Setting.app_name}#{t("companycommon.yellowpage")}")
      drop_breadcrumb(t("companycommon.yellowpage"))
  end

  
  def index
  # drop_breadcrumb(t("companycommon.yellowpage"))
   set_seo_meta(t("companycommon.yellowpage"),"#{Setting.app_name}#{t("companycommon.yellowpage")}")
   drop_breadcrumb(t("topics.hot_topic"),:use_route => :rforum)
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
    set_seo_meta("#{@company.name}","#{Setting.app_name}#{t("companycommon.yellowpage")}")
    drop_breadcrumb(t("companies.mycompany"))
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end  
  

  # GET /companies/new
  # GET /companies/new.xml
  def new
    if current_user.company
    redirect_to edit_company_path(current_user.company) 
    return
   end

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
    drop_breadcrumb(t("companies.edit"))
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
  

  protected

  def init_base_breadcrumb
    drop_breadcrumb(t("companycommon.shangjiapage"), rcompany.companiessearch_path)
  end
end
end
