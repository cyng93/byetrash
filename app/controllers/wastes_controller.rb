class WastesController < ApplicationController

  def index
    @wastes = Waste.all
    @waste = Waste.new
  end

  def show
    @waste = Waste.find(params[:id])
  end

  def new
    @waste = Waste.new
  end

  def edit
    @waste = Waste.find(params[:id])
  end

  def create
    @waste = Waste.new(waste_params)

    if @waste.save
      redirect_to waste_path(@waste)
    else
      render 'new'
    end
  end

  def update
    @waste = Waste.find(params[:id])

    if @waste.update(waste_params)
      redirect_to @waste
    else
      render 'edit'
    end
  end

  def destroy
    @waste = Waste.find(params[:id])
    @waste.destroy

    redirect_to wastes_path
  end


private
  def waste_params
    params.require(:waste).permit(:name,
                                  :description,
                                  :weight)
  end
end
