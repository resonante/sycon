class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy]

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    if request.url.match('change_orders')
      if params[:id]
        @purchase_order = PurchaseOrder.find(params[:id])
        @purchase_orders = PurchaseOrder.where(parent_id: params[:id]).includes(:customer, :work)
        @dataurl = "/purchase_orders/#{params[:id]}/change_orders"
      else
        @purchase_orders = PurchaseOrder.where('parent_id IS NOT NULL').includes(:customer, :work)
        @dataurl = "/change_orders"
      end
    else
      @purchase_orders = PurchaseOrder.where('parent_id IS NULL').includes(:customer, :work)
      @dataurl = '/purchase_orders'
    end
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show
    @customer = @purchase_order.customer
    @supplier = @purchase_order.supplier
    @work = @purchase_order.work
    @purchase_order_items = @purchase_order.purchase_order_items.order('item ASC')
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "file_name", :template => 'purchase_orders/pdfshow.html.erb', encoding: 'UTF-8'
      end
    end    
  end

  # GET /purchase_orders/new
  def new
    @works = Work.all
    @customers = Customer.all
    @suppliers = Supplier.all
    @purchase_order = PurchaseOrder.new
    #@purchase_order.reference = Time.now.strftime("%m%Y")
    @purchase_order.purchase_order_items.build
  end

  def clone
    @order = PurchaseOrder.find(params[:id])
    if !@order.parent_id.nil?
      @parent_purchase_order = PurchaseOrder.find(params[:id]).parent
    else
      @parent_purchase_order = @order
    end 
    @last_valuation = @parent_purchase_order.valuations.order('reference DESC').first.reference
    orders_count = (@parent_purchase_order.childs.count + 1).to_s
    @purchase_order = PurchaseOrder.create(
                        customer_id: @parent_purchase_order.customer_id,
                        supplier_id: @parent_purchase_order.supplier_id,
                        work_id: @parent_purchase_order.work_id,
                        parent_id: @parent_purchase_order.id,
                        init_valuation: @last_valuation,
                        reference: @parent_purchase_order.reference + '-' + orders_count,
                        description: @parent_purchase_order.reference + '-' + orders_count,
                        issue_date: @parent_purchase_order.issue_date,
                        begin_date: @parent_purchase_order.begin_date,
                        due_date: @parent_purchase_order.due_date)
    @order.purchase_order_items.each do |item|
      PurchaseOrderItem.create(
        purchase_order_id: @purchase_order.id,
        item: item.item,
        description: item.description,
        unit: item.unit,
        quantity: item.quantity,
        price: item.price)
    end
    redirect_to edit_purchase_order_path(@purchase_order)
  end

  # GET /purchase_orders/1/edit
  def edit
    @works = Work.all
    @customers = Customer.all
    @suppliers = Supplier.all
    @purchase_order_items_count = @purchase_order.purchase_order_items.size - 1
    @purchase_order.purchase_order_items.build
  end

  # POST /purchase_orders
  # POST /purchase_orders.json
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    @purchase_order.reference = Time.now.strftime("%m%y") + '-' +(PurchaseOrder.where("EXTRACT(MONTH FROM created_at) = #{Time.now.strftime("%m")} AND parent_id IS NULL").count + 1).to_s
    respond_to do |format|
      if @purchase_order.save
        format.html { redirect_to @purchase_order, notice: t('purchase_orders.success_create') }
        format.json { render :show, status: :created, location: @purchase_order }
      else
        format.html { render :new }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_orders/1
  # PATCH/PUT /purchase_orders/1.json
  def update
    respond_to do |format|
      if @purchase_order.update(purchase_order_params)
        format.html { redirect_to @purchase_order, notice: t('purchase_orders.success_update') }
        format.json { render :show, status: :ok, location: @purchase_order }
      else
        format.html { render :edit }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.json
  def destroy
    @purchase_order.destroy
    respond_to do |format|
      format.html { redirect_to purchase_orders_url, notice: 'Orden de Compra eliminada.' }
      format.json { head :no_content }
    end
  end

  def preview_pdf
    @products = Product.all
 
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end
 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_params
      params.require(:purchase_order).permit(:customer_id, :supplier_id, :work_id, :issue_date, :begin_date, :due_date, :reference, purchase_order_items_attributes: [:id, :item, :description, :unit, :quantity, :price, :_destroy])
    end

end
