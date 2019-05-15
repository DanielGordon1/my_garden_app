class PlantsController < ApplicationController
  def create
    # -> ???
    # step 1 find the garden
    @garden = Garden.find(params[:garden_id])
    # step 2 create a plant
    @plant = Plant.new(plant_params)
    # step 3 link the plant and garden
    # @plant.garden_id = garden.id
    @plant.garden = @garden
    # step 4 save the plant
    if @plant.save
      redirect_to garden_path(@garden)
    else
      # Render does not make another http request
      # It fetches the specified view template and sticks it on top of w/e you are looking at
      render 'gardens/show'
    end
    # step 5 if saved, redirect
  end

  def destroy
    @plant = Plant.find(params[:id])
    @plant.destroy
    # The plant will 'always' live on in memory. :)
    # Untill the Garbage Collector removes it.
    redirect_to garden_path(@plant.garden)
  end

  private
  def plant_params
    params.require(:plant).permit(:name, :image_url)
  end
end
