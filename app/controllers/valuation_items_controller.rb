class ValuationItemsController < ApplicationController
  before_action :set_valuation_item, only: [:show, :edit, :update, :destroy]

  # GET /valuation_items
  # GET /valuation_items.json
  def index
    @valuation_items = ValuationItem.all
  end

  # GET /valuation_items/1
  # GET /valuation_items/1.json
  def show
  end

  # GET /valuation_items/new
  def new
    @valuation_item = ValuationItem.new
  end

  # GET /valuation_items/1/edit
  def edit
  end

  # POST /valuation_items
  # POST /valuation_items.json
  def create
    @valuation_item = ValuationItem.new(valuation_item_params)

    respond_to do |format|
      if @valuation_item.save
        format.html { redirect_to @valuation_item, notice: 'Valuation item was successfully created.' }
        format.json { render :show, status: :created, location: @valuation_item }
      else
        format.html { render :new }
        format.json { render json: @valuation_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /valuation_items/1
  # PATCH/PUT /valuation_items/1.json
  def update
    respond_to do |format|
      if @valuation_item.update(valuation_item_params)
        format.html { redirect_to @valuation_item, notice: 'Valuation item was successfully updated.' }
        format.json { render :show, status: :ok, location: @valuation_item }
      else
        format.html { render :edit }
        format.json { render json: @valuation_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /valuation_items/1
  # DELETE /valuation_items/1.json
  def destroy
    @valuation_item.destroy
    respond_to do |format|
      format.html { redirect_to valuation_items_url, notice: 'Valuation item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_valuation_item
      @valuation_item = ValuationItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def valuation_item_params
      params[:valuation_item]
    end
end
