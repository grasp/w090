# coding: utf-8
class Rcompany::CompaniesController < Rcompany::ApplicationController
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
   # @company = Company.where(:user_id =>session[:user_id]).first #only one company actully
   @companies = Company.desc(:created_at).paginate(:page=>params[:page]||1,:per_page=>25)
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
    @company_name=@company.name
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end
  
  

  # GET /companies/new
  # GET /companies/new.xml
  def new

    @company=current_user.company.new

    respond_to do |format|
        format.html # new.html.erb 
      #  format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    if params[:id]
    @company = Company.find(params[:id])   
    elsif session[:user_id]
  #  @company=Company.where(:user_name =>session[:user_name].to_s).first #only one company actull
  @company=Company.where(:user_id =>session[:user_id].to_s).first #only one company actull
    unless @company
      redirect_to :action => "new"
    end
    end
    
    #  if @company.fix_phone.match(/-/)
    # @company.quhao=@company.fix_phone.split(/-/)[0]
    # @company.fix_phone=@company.fix_phone.split(/-/)[1]
    # else
    #   @company.quhao=""
    #   @company.fix_phone=@company.fix_phone
    #  end
  end

  # POST /companies
  # POST /companies.xml
  def create
    # params[:company][:fix_phone]=params[:quhao]+"-"+ params[:company][:fix_phone]
    @company = Company.new(params[:company])  

    respond_to do |format|
      if @company.save
        @user=User.find(session[:user_id])
        raise if @user.blank?
        @user.update_attributes({:company_id=>@company.id})
         expire_fragment "yellowpage"
         expire_fragment "users_center_#{session[:user_id]}"
        flash[:notice] = '公司成功创建，恭喜你创建完成了!'
         session[:user_id]=@user.id
        format.html {  redirect_to :action=>"show",:id=>@company.id}
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        flash[:notice] = '公司创建失败了,再次创建试试看？'
        format.html {  render :action=>"new"}
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    #params[:company][:fix_phone]=params[:quhao]+"-"+ params[:company][:fix_phone]
    @company= Company.find(params[:id])
    #company = update_company(params)
    expire_fragment "users_center_#{session[:user_id]}"
    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:notice] = "公司信息成功更新"
        #  format.html { redirect_to(@company) }
         format.html {  redirect_to :action=>"privatecenter"}
        format.xml  { head :ok }
      else
        flash[:notice] << " 公司信息更新失败"
        format.html { render :action => "edit" }
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
