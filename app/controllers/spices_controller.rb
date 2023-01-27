class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  def index
    render json: Spice.all
  end

  def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end

  def update
   spice = Spice.find_by(id: params[:id])
   spice.update(spice_params)
   render json: spice
  end

  def destroy
    spice = Spice.find_by(id: params[:id])
    spice.destroy
    head :no_content
  end

  private

  ## we use this to define which pieces of information are allowed to be 
  ## edited by the params hash 
  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def find_spice
    Spice.find_by(id: params[:id])
  end

  def not_found
    render json: { error: "Spice does not exist" }, status: :not_found
  end

end
