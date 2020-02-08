class AccessoriesController < ApplicationController
  def index
  end

  def show
    @accessories = Accessory.all
  end

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.new(accessory_params)

    return redirect_to @accessory,
           notice: 'Acessório registrado com sucesso' if @accessory.save!
  end

  private

  def accessory_params
    params.require(:accessory).permit(:name, :description, :daily_rate, :photo)
  end
end