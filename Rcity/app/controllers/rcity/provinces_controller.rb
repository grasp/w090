module Rcity
  class ProvincesController < Rcity::RcityController
    # GET /provinces
    # GET /provinces.json
    def index
      @provinces = Province.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @provinces }
      end
    end
  
    # GET /provinces/1
    # GET /provinces/1.json
    def show
      @province = Province.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @province }
      end
    end
  
    # GET /provinces/new
    # GET /provinces/new.json
    def new
      @province = Province.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @province }
      end
    end
  
    # GET /provinces/1/edit
    def edit
      @province = Province.find(params[:id])
    end
  
    # POST /provinces
    # POST /provinces.json
    def create
      @province = Province.new(params[:province])
  
      respond_to do |format|
        if @province.save
          format.html { redirect_to @province, notice: 'Province was successfully created.' }
          format.json { render json: @province, status: :created, location: @province }
        else
          format.html { render action: "new" }
          format.json { render json: @province.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /provinces/1
    # PUT /provinces/1.json
    def update
      @province = Province.find(params[:id])
  
      respond_to do |format|
        if @province.update_attributes(params[:province])
          format.html { redirect_to @province, notice: 'Province was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @province.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @province = Province.find(params[:id])
      @province.destroy
      redirect_to provinces_url
    end

  def nav
    @country=Country.where(:code=>"086").first#hard code
    @provinces=@country.provinces.asc(:code).to_a    
    @province=Province.where(:code=>params[:province_id].slice(0,2)+"0000000000").first
    @regions=@province.regions    
  end
 end
end
