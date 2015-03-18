class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy]

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    @purchase_orders = PurchaseOrder.all.includes(:customer, :work)
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show
  end

  # GET /purchase_orders/new
  def new
    @works = Work.all
    @customers = Customer.all
    @suppliers = Supplier.all
    @purchase_order = PurchaseOrder.new
    @purchase_order.purchase_order_items.build
  end

  # GET /purchase_orders/1/edit
  def edit
    @works = Work.all
    @customers = Customer.all
    @suppliers = Supplier.all
    @purchase_order_items_count = @purchase_order.purchase_order_items.size
    @purchase_order.purchase_order_items.build
  end

  # POST /purchase_orders
  # POST /purchase_orders.json
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
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
      format.html { redirect_to purchase_orders_url, notice: 'Purchase order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_params
      params.require(:purchase_order).permit(:customer_id, :supplier_id, :work_id, :issue_date, :begin_date, :due_date, :reference, purchase_order_items_attributes: [:id, :item, :description, :unit, :quantity, :price])
    end

end
