class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]
  load_and_authorize_resource

  # GET /services
  # GET /services.json
  def index
    prepare_search
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
    @address = @service.build_address
    @subarea = @service.build_subarea
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  # rubocop:disable Metrics/AbcSize
  def create
    @service = current_user.services.build(service_params)
    respond_to do |format|
      if @service.save
        format.html { redirect_to dashboard_path, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @service = Service.find(params[:id])
    @service.liked_by current_user
    redirect_to :back
  end

  def downvote
    @service = Service.find(params[:id])
    @service.downvote_by current_user
    redirect_to :back
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def service_params
    address_attributes = [:id, :street, :number, :complement, :neighborhood, :city_id, :state_id]
    params.require(:service).permit(:name,
                                    :description,
                                    :phone,
                                    :other_phone,
                                    :subarea_id,
                                    :owner_name,
                                    :owner_email,
                                    :website,
                                    address_attributes: address_attributes)
  end

  def prepare_search
    @services = Service.where(nil) # creates an anonymous scope
    @services = @services.text_search(params[:search]) unless params[:search].blank?
    if params[:state] && params[:state][:state_id].present?
      @services = @services.state_search(params[:state][:state_id])
    end
    @services = @services.city_search(params[:city][:city_id]) if params[:city] && params[:city][:city_id].present?
  end
end
