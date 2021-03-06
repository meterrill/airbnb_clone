class PropertiesController < ApplicationController
  def new
    @properties = Property.all
    @property = Property.new
  end

  def create
    @property = current_user.properties.new(property_params)
    if @property.save
      flash[:notice] = "Property successfully added!"
      redirect_to property_path(@property)
    else
      flash[:alert] = "There was a problem saving your property"
      redirect_to new_property_path
    end
  end

  def show
    @property = Property.find(params[:id])
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to root_path
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      redirect_to property_path(@property)
    else
      render :edit
    end
  end

private
  def property_params
    params.require(:property).permit(:name, :description, :price, :photo)
  end
end
