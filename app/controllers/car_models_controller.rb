class CarModelsController < ApplicationController
    before_action :authenticate_user!, only:[:index, :show, :edit, :new]
    before_action :set_car_model, only:[:show,:edit,:update,:destroy]
    def index
        @car_models = CarModel.all
    end

    def show
    end

    def new
        @car_model = CarModel.new
        @manufacturers = Manufacturer.all
        @car_categories = CarCategory.all
    end

    def edit
        @manufacturers = Manufacturer.all
        @car_categories = CarCategory.all
    end

    def create
        @car_model = CarModel.new(car_model_params)

        return redirect_to @car_model, 
                notice: 'Registrado com sucesso' if @car_model.save
        
        @manufacturers = Manufacturer.all
        @car_categories = CarCategory.all
        render :new
        
    end
    
    def update
        return redirect_to @car_model,
                notice: 'Editado com sucesso' if @car_model.update(car_model_params)
        
        @manufacturers = Manufacturer.all
        @car_categories = CarCategory.all
        render :edit
    end
    def destroy
        return redirect_to car_models_path, notice: 'Modelo de carro excluído com sucesso' if @car_model.destroy

    end
    private

    def set_car_model
        @car_model = CarModel.find(params[:id])
    end
    def car_model_params
        params.require(:car_model).permit(:name,:year,:manufacturer_id,:motorization,
                                    :car_category_id,:fuel_type)
    end
end