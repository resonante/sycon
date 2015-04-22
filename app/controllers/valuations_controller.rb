class ValuationsController < ApplicationController
  before_action :set_valuation, only: [:show, :edit, :update, :destroy]

  # GET /valuations
  # GET /valuations.json
  def index
    if params[:purchase_order_id]
      @purchase_order = PurchaseOrder.find(params[:purchase_order_id])
      @valuations = @purchase_order.valuations
      @data_url = "/purchase_orders/#{params[:purchase_order_id]}/valuations"

    else
      @valuations = Valuation.all
      @data_url = "/valuations"
    end
  end

  # GET /valuations/1
  # GET /valuations/1.json
  def show
    @purchase_order = @valuation.purchase_order
    @customer = @purchase_order.customer
    @supplier = @purchase_order.supplier
    @work = @purchase_order.work
    @purchase_order_items = @purchase_order.purchase_order_items
    @order_total = @purchase_order.purchase_order_items.sum('quantity * price')
    @acumulated_before = ValuationItem.includes(:valuation).where('reference < '+@valuation.reference.to_s).sum(:value)
    @acumulated = ValuationItem.includes(:valuation).where('reference < '+@valuation.reference.to_s).sum(:value)
    @rest_value = @purchase_order.purchase_order_items.sum('quantity * price') - (@acumulated + @valuation.valuation_items.sum(:value))
  end

  # GET /valuations/new
  def new
    @valuation = Valuation.new
    @purchase_order = PurchaseOrder.find(params[:purchase_order_id])
    @purchase_order_items = @purchase_order.purchase_order_items
    @last_valuation = @purchase_order.valuations.order('reference DESC').first
    @acumulated_before = @last_valuation.nil? ? 0 : ValuationItem.includes(:valuation).where('reference < '+@last_valuation.reference.to_s).sum(:value)
    @acumulated = @last_valuation.nil? ? 0 : ValuationItem.includes(:valuation).where('reference < '+@last_valuation.reference.to_s).sum(:value)
    @valuation.valuation_items.build
  end

  # GET /valuations/1/edit
  def edit
    @purchase_order = @valuation.purchase_order
    @purchase_order_items = @purchase_order.purchase_order_items
    @acumulated_before = ValuationItem.includes(:valuation).where('reference < '+@valuation.reference.to_s).sum(:value)
    @acumulated = ValuationItem.includes(:valuation).where('reference < '+@valuation.reference.to_s).sum(:value)
    @valuation.valuation_items.build
  end

  # POST /valuations
  # POST /valuations.json
  def create
    @valuation = Valuation.new(valuation_params)
    @valuation.purchase_order_id = params[:purchase_order_id]
    @purchase_order = @valuation.purchase_order
    @purchase_order_items = @purchase_order.purchase_order_items  
    ref = @purchase_order.valuations.size
    @valuation.reference = ref + 1  
    respond_to do |format|
      if @valuation.save
        @purchase_order_items.each do |item|
          ValuationItem.create(valuation_id: @valuation.id, purchase_order_item_id: item.id, value: params[:valuation][:valuation_items][item.id.to_s])
        end        
        format.html { redirect_to @valuation, notice: t('valuations.success_create') }
        format.json { render :show, status: :created, location: @valuation }
      else
        format.html { render :new }
        format.json { render json: @valuation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /valuations/1
  # PATCH/PUT /valuations/1.json
  def update
    respond_to do |format|
      @purchase_order = @valuation.purchase_order
      @purchase_order_items = @purchase_order.purchase_order_items
      @purchase_order_items.each do |item|
        @valuation_item = @valuation.valuation_items.where(purchase_order_item_id: item.id).first
        @valuation_item.update(value: params[:valuation][:valuation_items][item.id.to_s])
      end  
      if @valuation.update(valuation_params)
        format.html { redirect_to @valuation, notice: t('valuations.success_update') }
        format.json { render :show, status: :ok, location: @valuation }
      else
        format.html { render :edit }
        format.json { render json: @valuation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /valuations/1
  # DELETE /valuations/1.json
  def destroy
    @valuation.destroy
    respond_to do |format|
      format.html { redirect_to valuations_url, notice: 'Valuation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_valuation
      @valuation = Valuation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def valuation_params
      params.require(:valuation).permit(:purchase_order_id, :title, :description, valuation_items: [])
    end
end
