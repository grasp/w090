module Rcargo
  class Cpanel::CargoBigCategoriesController < ApplicationController
    # GET /cpanel/cargo_big_categories
    # GET /cpanel/cargo_big_categories.json
    def index
      @cpanel_cargo_big_categories = Rcargo::CargoBigCategory.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @cpanel_cargo_big_categories }
      end
    end
  
    # GET /cpanel/cargo_big_categories/1
    # GET /cpanel/cargo_big_categories/1.json
    def show
      @cpanel_cargo_big_category = Rcargo::CargoBigCategory.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @cpanel_cargo_big_category }
      end
    end
  
    # GET /cpanel/cargo_big_categories/new
    # GET /cpanel/cargo_big_categories/new.json
    def new
      @cpanel_cargo_big_category = Rcargo::CargoBigCategory.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @cpanel_cargo_big_category }
      end
    end
  
    # GET /cpanel/cargo_big_categories/1/edit
    def edit
      @cpanel_cargo_big_category = Rcargo::CargoBigCategory.find(params[:id])
    end
  
    # POST /cpanel/cargo_big_categories
    # POST /cpanel/cargo_big_categories.json
    def create
      @cpanel_cargo_big_category = Rcargo::CargoBigCategory.new(params[:cargo_big_category])
  
      respond_to do |format|
        if @cpanel_cargo_big_category.save
          format.html { redirect_to cpanel_cargo_big_category_path(@cpanel_cargo_big_category), notice: 'Cargo big category was successfully created.' }
          format.json { render json: @cpanel_cargo_big_category, status: :created, location: @cpanel_cargo_big_category }
        else
          format.html { render action: "new" }
          format.json { render json: @cpanel_cargo_big_category.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /cpanel/cargo_big_categories/1
    # PUT /cpanel/cargo_big_categories/1.json
    def update
      @cpanel_cargo_big_category = Rcargo::CargoBigCategory.find(params[:id])
  
      respond_to do |format|
        if @cpanel_cargo_big_category.update_attributes!(params[:cargo_big_category])
          format.html { redirect_to cpanel_cargo_big_category_path(@cpanel_cargo_big_category), notice: 'Cargo big category was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @cpanel_cargo_big_category.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /cpanel/cargo_big_categories/1
    # DELETE /cpanel/cargo_big_categories/1.json
    def destroy
      @cpanel_cargo_big_category = Rcargo::CargoBigCategory.find(params[:id])
      @cpanel_cargo_big_category.destroy
  
      respond_to do |format|
        format.html { redirect_to cpanel_cargo_big_categories_url }
        format.json { head :no_content }
      end
    end
  end
end
