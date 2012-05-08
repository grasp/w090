 # coding: utf-8
module Rtruck
class StockTrucksController < Rtruck::ApplicationController
  # GET /stock_trucks
  # GET /stock_trucks.xml
  before_filter:require_user
  protect_from_forgery :except => [:tip,:login]
  include Rtruck::StockTrucksHelper
  #layout "public", :except => [:oper]
  layout :choose_layout
  
    def choose_layout

    #return nil if action_name=='show'
    return "rtheme/rtruck"
   # return 'usercenter' if action_name=='index' || action_name=='new' || action_name=='edit'
   # return 'public'
  end
  def index
    @stock_trucks=current_user.stock_trucks
   # @stock_trucks = StockTruck.where(:user_id =>session[:user_id]).desc(:created_at).paginate(:page=>params[:page]||1,:per_page=>5)
   # respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @stock_trucks }
   # end

    drop_breadcrumb(t("stock_trucks.stock_trucks"))
  end    



  # GET /stock_trucks/1
  # GET /stock_trucks/1.xml
  def show
    @stock_truck = StockTruck.find(params[:id])
    drop_breadcrumb(t("stock_trucks.stock_trucks"),stock_trucks_path)
    drop_breadcrumb(@stock_truck.paizhao+t("stock_trucks.detail"))
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stock_truck }
    end
  end

  # GET /stock_trucks/new
  # GET /stock_trucks/new.xml
  def new
    @stock_truck = current_user.stock_trucks.new
    @stock_truck.status="空闲"
    drop_breadcrumb(t("stock_trucks.stock_trucks"),stock_trucks_path)
    drop_breadcrumb(t("stock_trucks.new"))
   # @stock_truck.company_id=@user.company_id unless @user.nil?

   # respond_to do |format|
    #  format.html # new.html.erb
   #   format.xml  { render :xml => @stock_truck }
   # end
  end

  def oper
    @stock_truck_id =params[:id]
     respond_to do |format|
      format.html # oper.html.erb
   #   format.xml  { render :xml => @stock_truck }
    end
  end

  # GET /stock_trucks/1/edit
  def edit
    @stock_truck = StockTruck.find(params[:id])   
    drop_breadcrumb(t("stock_trucks.stock_trucks"),stock_trucks_path)
    drop_breadcrumb(t("stock_trucks.edit")) 
  end

  # POST /stock_trucks
  # POST /stock_trucks.xml
  def create
     @stock_truck=current_user.stock_trucks.build(params[:stocktruck])
         

    respond_to do |format|
      if @stock_truck.save
        flash[:notice] = '成功创建车辆'
             format.html { redirect_to :action=>"index"}
      # format.html {redirect_to :controller=>"dingwei",:action=>"list_all_truck",:notice=>flash[:notice]}
      #  format.xml  { render :xml => @stock_truck, :status => :created, :location => @stock_truck }
      else
        flash[:notice] = '创建车辆失败,该牌照huo已经存在'
        format.html { render :action => "new" }
       #   format.html {redirect_to :controller=>"dingwei",:action=>"newtruck",:notice=>flash[:notice]}
      #  format.xml  { render :xml => @stock_truck.errors, :status => :unprocessable_entity }
      end
    end
   
  end

  # PUT /stock_trucks/1
  # PUT /stock_trucks/1.xml
  def update
    @stock_truck = StockTruck.find(params[:id])

    respond_to do |format|
      if @stock_truck.update_attributes(params[:stocktruck])
        flash[:notice] = '成功更新了车子基本信息.'
        
        format.html { redirect_to :action=>"index" }
        format.xml  { head :ok }
      else
         flash[:notice] = '更新车子基本信息失败.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stock_truck.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_trucks/1
  # DELETE /stock_trucks/1.xml
  def destroy    
    @stock_truck = StockTruck.find(params[:id])
    @stock_truck.destroy

    respond_to do |format|
      format.html { redirect_to(stock_trucks_url) }
      format.xml  { head :ok }
    end
  end
end
end
