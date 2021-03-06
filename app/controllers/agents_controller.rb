class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  # GET /agents
  # GET /agents.json
  def index
    @agents = Agent.all
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
  end

  # GET /agents/new
  def new
    @agent = Agent.new
    @works = Work.all
    @customers = Customer.all
  end

  # GET /agents/1/edit
  def edit
    @customers = Customer.all
    @works = Work.all
  end

  # POST /agents
  # POST /agents.json
  def create
    @agent = Agent.new(agent_params)
    @agent.works << Work.find(params[:works]) if params[:works]
    @customers = Customer.all
    @works = Work.all
    respond_to do |format|
      if @agent.save
        User.invite!(:email => params[:agent][:email]) do |u|
          u.roles << Role.find(4)
          u.skip_invitation = true
          u.save
        end
        format.html { redirect_to @agent, notice: t('agents.success_create') }
        format.json { render :show, status: :created, location: @agent }
      else
        format.html { render :new }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agents/1
  # PATCH/PUT /agents/1.json
  def update
    @agent.works.delete_all
    @agent.works << Work.find(params[:works])
    @customers = Customer.all
    @works = Work.all    
    respond_to do |format|
      if @agent.update(agent_params)
        format.html { redirect_to @agent, notice: t('agents.success_update') }
        format.json { render :show, status: :ok, location: @agent }
      else
        format.html { render :edit }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.json
  def destroy
    @agent.destroy
    respond_to do |format|
      format.html { redirect_to agents_url, notice: 'Agent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agent_params
      params.require(:agent).permit(:customer_id, :name, :email,:password, :address, :phone, :mobile, :state, :town, :description)
    end
end
