class PlantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  def update
    plant = Plant.find(params[:id])
    if plant 
      in_stock = plant.is_in_stock
      plant.update(is_in_stock: !in_stock)
      render json: plant
    end

  end

  def destroy
    plant = Plant.find(params[:id])
    if plant 
      plant.destroy()
      head :no_content
    end
  end

  private

  def render_not_found_response
    render json: {error: "plant not found"}, status: :not_found
  end

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end
end
