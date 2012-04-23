module Rcity
  class ChengsController < Rcity::RcityController
    # GET /chengs
    # GET /chengs.json
    layout :nil,:only=>[:lineselect]
    def index
      @chengs =Rcity::Cheng.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @chengs }
      end
    end
  
    # GET /chengs/1
    # GET /chengs/1.json
    def show
      @cheng =Rcity::Cheng.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @cheng }
      end
    end
  
    # GET /chengs/new
    # GET /chengs/new.json
    def new
      @cheng =Rcity::Cheng.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @cheng }
      end
    end
  
    # GET /chengs/1/edit
    def edit
      @cheng =Rcity::Cheng.find(params[:id])
    end
  
    # POST /chengs
    # POST /chengs.json
    def create
      @cheng =Rcity::Cheng.new(params[:cheng])
  
      respond_to do |format|
        if @cheng.save
          format.html { redirect_to @cheng, notice: 'Cheng was successfully created.' }
          format.json { render json: @cheng, status: :created, location: @cheng }
        else
          format.html { render action: "new" }
          format.json { render json: @cheng.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /chengs/1
    # PUT /chengs/1.json
    def update
      @cheng =Rcity::Cheng.find(params[:id])
  
      respond_to do |format|
        if @cheng.update_attributes(params[:cheng])
          format.html { redirect_to @cheng, notice: 'Cheng was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @cheng.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /chengs/1
    # DELETE /chengs/1.json
    def destroy
      @cheng =Rcity::Cheng.find(params[:id])
      @cheng.destroy
  
      respond_to do |format|
        format.html { redirect_to chengs_url }
        format.json { head :no_content }
      end
    end

    def nav
        @country=Country.where(:code=>"086").first#hard code
        @provinces=@country.provinces.asc(:code).to_a    
        @province=Province.where(:code=>params[:cheng_id].slice(0,2)+"0000000000").first
        @regions=@province.regions 
    end

    def lineselect
        params[:cheng_id]="330100000000" if params[:cheng_id].nil?
        @country=Country.where(:code=>"086").first#hard code
        @provinces=@country.provinces.asc(:code).to_a    
        @province=Province.where(:code=>params[:cheng_id].slice(0,2)+"0000000000").first
        @regions=@province.regions 
        @match_province=params[:cheng_id].slice(0,2)+"0000000000"
        @match_region=params[:cheng_id].slice(0,4)+"00000000"
        @match_cheng=params[:cheng_id].slice(0,6)+"000000"        
    end


  end
end
