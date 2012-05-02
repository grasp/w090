# coding: utf-8
module Rtruck
class TrucksController < Rtruck::ApplicationController
  # GET /trucks
  # GET /trucks.xml

  include Rtruck::TrucksHelper
  #include Rcargo::CargosHelper
  # before_filter:authorize, :except => [:search,:show,:baojiatruck]
 # before_filter:authorize, :only => [:new,:create,:update,:destroy,:edit,:quoteinquery,:request_chenjiao]
  before_filter:require_user
  protect_from_forgery :except => [:tip,:login,:post_truck,:quickfabu]
  # layout "public"
  # caches_page :search,:show
   caches_page :show
  # layout 'public' ,:except => [:show,:search]
   
  layout :choose_layout  
  
  def choose_layout
    return "rtheme/rtruck"
    #return 'usercenter'  if action_name =='index'      
   # return  nil if  action_name=="show"
   # return "usercenter" if action_name=="new"
   # return 'truck'
  end
  
  def quickfabu

    quickfabu_helper
      respond_to do |format|
      format.html {render :flash=>{:notice=>flash[:notice]}}
       #   :to=>flash[:to],:contact=>flash[:contact],:cargoname=>flash[:cargoname],:chelength=>flash[:chelength],:comments=>flash[:comments],
     #     :send_date=>flash[:send_date],:weight=>flash[:weight],:zuhuo=>flash[:zuhuo]}}
      #   format.xml  { render :xml => @cargo }
    end
  end
   
  def public
    @trucks =  Truck.all(:user_id =>session[:user_id])
    render :template => 'trucks/public/index'
  end

  def index
     drop_breadcrumb(t("stock_trucks.stock_trucks"),stock_trucks_path)
     drop_breadcrumb(t("trucks.trucks"),trucks_path)
    @trucks=current_user.trucks
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trucks }
    end
  end
  
  
  def search
     @trucks=Truck.desc(:created_at).paginate(:page=>params[:page]||1,:per_page=>20)
    if false
    @search=Search.new
    if params[:search].nil? then
      #puts "params[:search] is nil"
    
      unless params[:from].blank?
        @search.fcity_code=params[:from]
        @search.fcity_name=$city_code_name[params[:from]]
      else
        @search.fcity_code="100000000000"
        @search.fcity_name="出发地选择"
      end
      unless params[:from].blank?
        @search.tcity_code=params[:to];@search.tcity_name=$city_code_name[params[:to]] 
      else
        @search.tcity_name="到达地选择"
        @search.tcity_code="100000000000"
      end

    else
      @search.fcity_name=params[:search][:fcity_name]
      @search.tcity_name=params[:search][:tcity_name]
      @search.fcity_code=params[:search][:fcity_code]
      @search.tcity_code=params[:search][:tcity_code]
    end

    @action_suffix="#{@search.fcity_code}#{@search.tcity_code}#{params[:page]}"
  
    @search.save
    
    @trucks=get_search_truck(@search.fcity_code,@search.tcity_code)
    respond_to do |format|
      if params[:layout]     
        format.html  
      else
        format.html {render :layout=>"truck"}
      end
    end
  end
  end

  def match
    # @truck = Truck.find(params[:truck_id])
    @truck = Truck.find(params[:truck_id])
    @search=Search.new
    @search.fcity_name=@truck.fcity_name
    @search.tcity_name=@truck.tcity_name
    @search.fcity_code=@truck.fcity_code
    @search.tcity_code=@truck.tcity_code
    
    if @search.fcity_code=="100000000000" && @search.tcity_code=="100000000000" then
      @trucks=Cargo.where(:status=>"正在配货").desc(:created_at).paginate(:page=>params[:page]||1,:per_page=>20)
    elsif @search.fcity_code=="100000000000" && @search.tcity_code!="100000000000"
      min=get_max_min_code(@search.tcity_code)[0]
      max=get_max_min_code(@search.tcity_code)[1]
      
      @trucks=Cargo.where({:tcity_code.gte=>min,:tcity_code.lt=>max,:status=>"正在配货"}).desc(:created_at).paginate(:page=>params[:page]||1,:per_page=>20)
    elsif @search.tcity_code=="100000000000" && @search.fcity_code!="100000000000"
      min=get_max_min_code(@search.fcity_code)[0]
      max=get_max_min_code(@search.fcity_code)[1]
      @trucks=Cargo.where({:fcity_code.gte =>min,:fcity_code.lt =>max,:status=>"正在配货"}).desc(:created_at).paginate(:page=>params[:page]||1,:per_page=>20)
    else
      mint=get_max_min_code(@search.tcity_code)[0]
      maxt=get_max_min_code(@search.tcity_code)[1]
      minf=get_max_min_code(@search.fcity_code)[0]
      maxf=get_max_min_code(@search.fcity_code)[1]
      @trucks=Cargo.where({:fcity_code.gte =>minf,:fcity_code.lt =>maxf,:tcity_code.gte=>mint,:tcity_code.lt=>maxt,:status=>"正在配货"}).desc(:created_at).paginate(:page=>params[:page]||1,:per_page=>20)
    end
  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @truck }
    end
  end

  # GET /trucks/1
  # GET /trucks/1.xml
  def show
    @truck=Truck.find(params[:id])
    @stock_truck=@truck.stock_truck
     drop_breadcrumb(t("stock_trucks.stock_trucks"),stock_trucks_path)
     drop_breadcrumb(t("trucks.trucks"),trucks_path)
     drop_breadcrumb(t("trucks.detail"))
     respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @truck }
    end
  end

  # GET /trucks/new
  # GET /trucks/new.xml
  def new
      params[:cheng_id]="330100000000" if params[:cheng_id].nil?
      @country=Rcity::Country.where(:code=>"086").first#hard code
      @provinces=@country.provinces.asc(:code).to_a    
      @province=Rcity::Province.where(:code=>params[:cheng_id].slice(0,2)+"0000000000").first
      @regions=@province.regions 
      @match_province=params[:cheng_id].slice(0,2)+"0000000000"
      @match_region=params[:cheng_id].slice(0,4)+"00000000"
      @match_cheng=params[:cheng_id].slice(0,6)+"000000" 

  if params[:stock_truck_id]
    @stock_truck = StockTruck.find(params[:stock_truck_id])  
    @truck = @stock_truck.trucks.new
    @truck.stock_truck_id=@stock_truck.id
    @truck.paizhao=@stock_truck.paizhao
    @truck.dunwei=@stock_truck.dunwei
    @truck.length=@stock_truck.length
    @truck.usage=@stock_truck.usage
    @truck.shape=@stock_truck.shape
    @truck.driver=@stock_truck.driver
    @truck.dphone=@stock_truck.dphone
    @truck.cphone=@stock_truck.cphone
  else
      @truck=Truck.new
  end  

  drop_breadcrumb(t("stock_trucks.stock_trucks"),stock_trucks_path)
  drop_breadcrumb(t("trucks.new2"))
   # @truck = current_user.trucks.new
   #@user_contact=UserContact.find_by_user_id(@user.id)
   #@user_contact=@user.user_contact_id
   #@company=@user.company_id
    
    @truck.from="local"
    @truck.status="正在配货"

   
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @truck }
    end

  end

  # GET /trucks/1/edit
  def edit
      params[:cheng_id]="330100000000" if params[:cheng_id].nil?
      @country=Rcity::Country.where(:code=>"086").first#hard code
      @provinces=@country.provinces.asc(:code).to_a    
      @province=Rcity::Province.where(:code=>params[:cheng_id].slice(0,2)+"0000000000").first
      @regions=@province.regions 
      @match_province=params[:cheng_id].slice(0,2)+"0000000000"
      @match_region=params[:cheng_id].slice(0,4)+"00000000"
      @match_cheng=params[:cheng_id].slice(0,6)+"000000" 

    @truck = Truck.find(params[:id])
    @stock_truck=StockTruck.find(@truck.stock_truck_id)
  end

  # POST /trucks
  # POST /trucks.xml
  def create

    @truck=current_user.trucks.build(params[:truck])
    @truck.line=@truck.fcityc+"#"+@truck.tcityc 
 
    respond_to do |format|
      if @truck.save
        flash[:notice] = '车源创建成功'       
        if params[:truck][:stock_truck_id]
          @truck.stock_truck.update_attribute(:status,"正在配货")
        end
        format.html { redirect_to :action=>"index"}
        format.xml  { render :xml => @truck, :status => :created, :location => @truck }
      else
        flash[:notice] = '车源创建失败，重复发布'
        # @stock_truck=StockTruck.find(@truck.stock_truck_id)
        format.html { redirect_to :action=>"new" }
        format.xml  { render :xml => @truck.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trucks/1
  # PUT /trucks/1.xml
  def update
    
  @truck = Truck.find(params[:id])
   #@stock_truck=StockTruck.find(@truck.stock_truck_id)
    #  @trucks = update_truck_info_from_params(params)    

    respond_to do |format|
      if @truck.update_attributes(params[:truck])
        flash[:notice] = '货源更新成功.'
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { redirect_to :action => "edit" }
        format.xml  { render :xml => @trucks.errors, :status => :unprocessable_entity }
      end
    end
  end
  def confirm_chenjiao
    
    @user=User.find(session[:user_id])
    @truck = Truck.find(params[:id])     
    #all other truck with same paizhao , need expire also
    Truck.where(:paizhao=>@truck.paizhao).each do |truck|
      truck.update_attribute("status","已成交")
    end
    
    Quote.where(:truck_id=>@truck.id).each do |quote|
      quote.update_attribute("status","成交过期")
    end
    Inquery.where(:truck_id=>@truck.id).each do |inquery|
      inquery.update_attribute("status","成交过期")
    end
    
    @quote=Quote.where(:truck_id=>@truck.id,:status=>"请求成交").first #should be only one
    @inquery=Inquery.where(:truck_id=>@truck.id , status=>"请求成交").first#should be only one
    @quote.update_attribute("status","已成交") unless @quote.blank?
    @inquery.update_attribute("status","已成交") unless @inquery.blank?

    #need update statistics
    @ustatistic=Ustatistic.where(:user_id=>@user.id).first
    @ustatistic.inc(:valid_truck,-1) if @ustatistic.valid_truck>0
    @ustatistic.inc(:total_truck,-1) if @ustatistic.total_truck>0
    
    
    #change stocktruck to idle
    @stock_truck=StockTruck.where(:paizhao=>@truck.paizhao).first
    @stock_truck.update_attribute("status","车辆闲置")
    
    respond_to do |format|
      format.html { redirect_to(:controller=>"trucks",:action=>"index" )}
    end


  end
  # DELETE /trucks/1
  # DELETE /trucks/1.xml
  def destroy
    @truck = Truck.find(params[:id])
    @truck.destroy

    respond_to do |format|
      format.html { redirect_to(trucks_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def allcity
    @quickfabu=Hash.new
  end
  
  def cityfrom
    @search=Search.new;    @search.fcity_code=params[:city_id];    @search.tcity_code="100000000000"
    @province=params[:city_id].slice(0,2)+"0000000000"
    cityid=params[:city_id]
    if cityid.match(/\d\d0000000000$/) # is a province id
      next_province=cityid.to_i+10000000000
      @trucks=Truck.where(:status=>"正在配货",:fcity_code.gte=>cityid.to_s,:fcity_code.lt=> next_province.to_s)
      .desc(:created_at).asc(:priority).paginate(:page=>params[:page]||1,:per_page=>25)
    elsif  cityid.match(/\d\d\d\d00000000$/)  and (not cityid.match(/\d\d0000000000$/))  # is a region
      next_region=cityid.to_i+100000000
      @trucks=Truck.where(:status=>"正在配货",:fcity_code.gte=>cityid.to_s,:fcity_code.lt=> next_region.to_s)
      .desc(:created_at).asc(:priority).paginate(:page=>params[:page]||1,:per_page=>25)
    else
      @trucks=Truck.where(:status=>"正在配货",:fcity_code=>cityid.to_s)
      .desc(:created_at).asc(:priority).paginate(:page=>params[:page]||1,:per_page=>25)
    end
  end
  def cityto
    @search=Search.new;    @search.tcity_code=params[:city_id];    @search.fcity_code="100000000000"
    @province=params[:city_id].slice(0,2)+"0000000000"
    cityid=params[:city_id]
    if cityid.match(/\d\d0000000000$/) # is a province id
      next_province=cityid.to_i+10000000000
      @trucks=Truck.where(:status=>"正在配货",:tcity_code.gte=>cityid.to_s,:tcity_code.lt=> next_province.to_s)
      .desc(:created_at).asc(:priority).paginate(:page=>params[:page]||1,:per_page=>25)
    elsif  cityid.match(/\d\d\d\d00000000$/)  and (not cityid.match(/\d\d0000000000$/))  # is a region
      next_region=cityid.to_i+100000000
      @trucks=Truck.where(:status=>"正在配货",:tcity_code.gte=>cityid.to_s,:tcity_code.lt=> next_region.to_s)
      .desc(:created_at).asc(:priority).paginate(:page=>params[:page]||1,:per_page=>25)
    else
      @trucks=Truck.where(:status=>"正在配货",:tcity_code=>cityid.to_s)
      .desc(:created_at).asc(:priority).paginate(:page=>params[:page]||1,:per_page=>25)
    end
    
  end

  def city
    city_level(params[:city_id]) #for title usage , SEO friendlly
  end
  
  def post_truck
    logger.info  "get post truck request"
    new_truck= eval(params[:truck]).to_hash  
    
    begin
      Truck.new(new_truck).save!
    rescue
      logger.info  "truck save excetion !!!!!"
    end
  end
  
end
end