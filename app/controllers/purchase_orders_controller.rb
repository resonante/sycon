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
    @customer = @purchase_order.customer
    @supplier = @purchase_order.supplier
    @work = @purchase_order.work
    @purchase_order_items = @purchase_order.purchase_order_items.order('item ASC')
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "file_name", :template => 'purchase_orders/show.html.erb'
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
    @purchase_order.reference = Time.now.strftime("%m%y") + '-' +(PurchaseOrder.where("EXTRACT(MONTH FROM created_at) = #{Time.now.strftime("%m")}").count + 1).to_s
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
