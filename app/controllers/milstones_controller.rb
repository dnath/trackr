require 'gchart'


class MilstonesController < ApplicationController
  # GET /milstones
  # GET /milstones.json
  def index

    @milstones = Milstone.all
    Gchart.line(:size => '200x300', 
            :title => "example title",
            :bg => 'efefef',
            :legend => ['first data set label', 'second data set label'],
            :data => [10, 30, 120, 45, 72])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @milstones }
    end
  end

  # GET /milstones/1
  # GET /milstones/1.json
  def show
    @milstone = Milstone.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @milstone }
    end
  end

  # GET /milstones/new
  # GET /milstones/new.json
  def new
    @milstone = Milstone.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @milstone }
    end
  end

  # GET /milstones/1/edit
  def edit
    @milstone = Milstone.find(params[:id])
  end

  # POST /milstones
  # POST /milstones.json
  def create
    @milstone = Milstone.new(params[:milstone])

    respond_to do |format|
      if @milstone.save
        format.html { redirect_to @milstone, notice: 'Milstone was successfully created.' }
        format.json { render json: @milstone, status: :created, location: @milstone }
      else
        format.html { render action: "new" }
        format.json { render json: @milstone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /milstones/1
  # PUT /milstones/1.json
  def update
    @milstone = Milstone.find(params[:id])

    respond_to do |format|
      if @milstone.update_attributes(params[:milstone])
        format.html { redirect_to @milstone, notice: 'Milstone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @milstone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /milstones/1
  # DELETE /milstones/1.json
  def destroy
    @milstone = Milstone.find(params[:id])
    @milstone.destroy

    respond_to do |format|
      format.html { redirect_to milstones_url }
      format.json { head :no_content }
    end
  end
end
