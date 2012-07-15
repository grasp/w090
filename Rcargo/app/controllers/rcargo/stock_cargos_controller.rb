# coding: utf-8
module Rcargo
class StockCargosController < Rcargo::ApplicationController
  # GET /stock_cargos
  # GET /stock_cargos.xml
  include StockCargosHelper
  before_filter:require_user
  protect_from_forgery :except => [:tip,:login]
  #layout 'public' ,:except => [:show]
 # layout :choose_layout
  def choose_layout
    return nil if action_name=='show'
    return 'usercenter' if action_name=='index' || action_name=='new'
    return 'public'
  end
  
  def index
 @stock_cargos = current_user.stock_cargos.paginate(:page=>params[:page]||1,:per_page=>20)

    drop_breadcrumb(t("stock_cargo.StockCargos"))
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stock_cargos }
    end
  end

  # GET /stock_cargos/1
  # GET /stock_cargos/1.xml
  def show
     @stock_cargo = StockCargo.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stock_cargo }
    end
  end

  # GET /stock_cargos/new
  # GET /stock_cargos/new.xml
  def new

    #init for line search
    
     drop_breadcrumb(t("stock_cargo.StockCargos"),stock_cargos_path)
    drop_breadcrumb(t("stock_cargo.new_stock_cargo"))
    @stock_cargo=current_user.stock_cargos.new

   # @stock_cargo.user_id=@user.id
   # @stock_cargo.company_id=@user.company_id unless @user.company_id.blank?
    @stock_cargo.status="无配车信息"##hard code
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stock_cargo }
    end
  end

  # GET /stock_cargos/1/edit
  def edit
    drop_breadcrumb(t("stock_cargo.StockCargos"),stock_cargos_path)
    drop_breadcrumb(t("stock_cargo.edit_stock_cargo"))
    @stock_cargo = StockCargo.find(params[:id])
  end

  # POST /stock_cargos
  # POST /stock_cargos.xml
  def create
    # result= get_stock_cargo_from_params(params)
    #  @stock_cargo = StockCargo.new(params)
    
    # params[:stockcargo][:package_name]= #init value
    #params[:stockcargo][:package_name]=$package_category_two[params[:stockcargo][:package_code]] #init value
    
    # unless params[:stockcargo][:cate_code].nil?
    #params[:stockcargo][:cate_name]=$cargo_category_two[params[:stockcargo][:cate_code]] #init value
    #  else
      
    #   end
    #params[:stockcargo][:status]="货物闲置" #init value
    #must initialilize ,otherwise $inc  in update will not work
    #params[:stockcargo][:valid_cargo]=0
    #params[:stockcargo][:total_cargo]=0
    #params[:stockcargo][:expired_cargo]=0
    #params[:stockcargo][:sent_weight]=0
   # params[:stockcargo][:sent_bulk]=0
   # params[:stockcargo][:user_id]=session[:user_id]  
    @stock_cargo = current_user.stock_cargos.build(params[:stock_cargo])
    respond_to do |format|
      if @stock_cargo.save
    # if current_user.stock_cargos.create!(params[:stockcargo])
        flash[:notice]="货物创建成功,点击下面的发布货源按钮，发布该类货物的货源信息"
       # Ustatistic.collection.update({'user_id' => session[:user_id]},{'$inc' => {"total_stock_cargo" => 1}})        
        # format.html { redirect_to(@stock_cargo) }
        format.html { redirect_to :action=>"index"}
        format.xml  { render :xml => @stock_cargo, :status => :created, :location => @stock_cargo }
      else
        flash[:notice] = '货物创建失败了！.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @stock_cargo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stock_cargos/1
  # PUT /stock_cargos/1.xml
  def update    

    @stock_cargo = current_user.stock_cargos.find(params[:id])
puts   @stock_cargo.cargoname
    respond_to do |format|
      if @stock_cargo.update_attributes!(params[:stock_cargo])
        flash[:notice] = '货物更新成功.'
        format.html { redirect_to(@stock_cargo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stock_cargo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_cargos/1
  # DELETE /stock_cargos/1.xml
  def destroy
    @stock_cargo = StockCargo.find(params[:id])
    @stock_cargo.destroy

    respond_to do |format|
      format.html { redirect_to(stock_cargos_url) }
      format.xml  { head :ok }
    end
  end
end
end
