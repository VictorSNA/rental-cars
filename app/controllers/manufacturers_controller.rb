class ManufacturersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show new edit]
  before_action :set_manufacturer, only: %i[show edit update destroy]
  def index
    @manufacturers = Manufacturer.all
  end

  def show
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def edit
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params) 
    return redirect_to @manufacturer, notice: 'Fabricante registrado com '\
      'sucesso' if @manufacturer.save

    render :new
  end

  def search
    @manufacturers = Manufacturer.where('name LIKE ?', "%#{params[:q].upcase}%")

    if @manufacturers.blank?
      flash[:notice] = 'Nenhuma locação encontrada'
    end
  end

  def update
    return redirect_to @manufacturer, 
      notice: 'Fabricante editado com sucesso'if @manufacturer.update(manufacturer_params)

    render :edit
  end

  def destroy
    return redirect_to manufacturers_path, notice: 'Fabricante excluído '\
      'com sucesso' if @manufacturer.destroy
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end

  def set_manufacturer
    @manufacturer = Manufacturer.find(params[:id])
  end
end
