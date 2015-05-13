class ValuationsController < ApplicationController
  before_action :set_valuation, only: [:show, :edit, :update, :destroy]

  # GET /valuations
  # GET /valuations.json
  def index
    if params[:purchase_order_id]
      @purchase_order = PurchaseOrder.find(params[:purchase_order_id])
      @valuations = Valuation.joins(:purchase_order).where("purchase_orders.id = #{@purchase_order.id.to_s} or purchase_orders.parent_id = #{@purchase_order.id.to_s}").order('reference asc')
      @data_url = "/purchase_orders/#{params[:purchase_order_id]}/valuations"
      @change_order = PurchaseOrder.find(@purchase_order.childs.last) if @purchase_order.childs.count > 0
    else
      @valuations = Valuation.all
      @data_url = "/valuations"
    end
  end

  # GET /valuations/1
  # GET /valuations/1.json
  def show
    @setting = Setting.first
    @purchase_order = @valuation.purchase_order
    @customer = @purchase_order.customer
    @supplier = @purchase_order.supplier
    @work = @purchase_order.work
    @purchase_order_items = @purchase_order.purchase_order_items
    
    # Total orden de compra / purchse order total
    @order_total = @purchase_order.purchase_order_items.sum('quantity * price')
    # Relación actual
    @actual = Valuation.find_by_sql("select sum(vi.value * pi.price) as total from valuation_items vi
                                          inner join purchase_order_items pi on pi.id = vi.purchase_order_item_id
                                          where vi.valuation_id = #{@valuation.id.to_s}").sum.total
    # Acumulado anterior
    @acumulated_before = Valuation.find_by_sql("select coalesce(sum(vi.value * pi.price), 0) as total from valuation_items vi
                                                inner join purchase_order_items pi on pi.id = vi.purchase_order_item_id
                                                inner join valuations v on v.id = vi.valuation_id
                                                where v.reference < #{@valuation.reference.to_s}").sum.total
    # Acumulado actual
    @acumulated = @actual + @acumulated_before
    # Lo que resta
    @rest_value = @order_total - @acumulated
    #
    @advance = @order_total * 0.30

    @advance_actual = @actual * 0.30

    @advance_before = (@actual + @acumulated_before) * 0.30

    @advance_rest = @advance - @advance_before

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "file_name", :template => 'valuations/pdfshow.html.erb', encoding: 'UTF-8'
      end
    end
  end

  # GET /valuations/new
  def new
    @valuation = Valuation.new
    @purchase_order = PurchaseOrder.find(params[:purchase_order_id])
    if @purchase_order.childs.size > 0
      @change_order = @purchase_order.childs.order('id desc').first
      @purchase_order = @change_order
      @purchase_order_items = @change_order.purchase_order_items
    else
      @purchase_order_items = @purchase_order.purchase_order_items  
    end  
    @last_valuation = @purchase_order.valuations.order('reference DESC').first
    @acumulated_before = @last_valuation.nil? ? 0 : ValuationItem.includes(:valuation).where('reference < '+@last_valuation.reference.to_s).sum(:value)
    @acumulated = @last_valuation.nil? ? 0 : ValuationItem.includes(:valuation).where('reference < '+@last_valuation.reference.to_s).sum(:value)
    @valuation.valuation_items.build
  end

  # GET /valuations/1/edit
  def edit
    @purchase_order = @valuation.purchase_order
    @purchase_order_items = @purchase_order.purchase_order_items  
    @valuations = Valuation.joins(:purchase_order).where("purchase_orders.id = #{@purchase_order.id.to_s} or purchase_orders.parent_id = #{@purchase_order.id.to_s}")
    @acumulated_before = ValuationItem.includes(:valuation).where('reference <= ' + @valuation.reference.to_s).sum(:value)
    @acumulated = ValuationItem.includes(:valuation).where('reference <= ' + @valuation.reference.to_s).sum(:value)
    @valuation.valuation_items.build
  end

  # POST /valuations
  # POST /valuations.json
  def create
    @valuation = Valuation.new(valuation_params)
    @valuation.purchase_order_id = params[:purchase_order_id]
    @purchase_order = @valuation.purchase_order
    ref = @purchase_order.parent.valuations.size + Valuation.where("purchase_order_id in (#{@purchase_order.parent.childs.select(:id).map{|a| a.id}.join(",")})").size
    @valuation.reference = ref + 1    
    @purchase_order_items = @purchase_order.purchase_order_items    
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
    purchase_order = @valuation.purchase_order.parent
    @valuation.destroy
    respond_to do |format|
      format.html { redirect_to purchase_order_valuations_url(purchase_order), notice: 'Valuation was successfully destroyed.' }
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
      params.require(:valuation).permit(:purchase_order_id, :title, :description, :invoice, valuation_items: [])
    end
end
