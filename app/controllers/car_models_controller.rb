class CarModelsController < ApplicationController
    def index
        @car_models = CarModel.all
    end

    def show
        @car_model = CarModel.find(params[:id])
    end
    
    def new
        @car_model = CarModel.new
        @manufacturers = Manufacturer.all
        @car_categories = CarCategory.all
    end

    def create
        @car_model = CarModel.new(car_model_params)

        if @car_model.save
            flash.now[:alert] = "Registrado com sucesso"
            redirect_to @car_model
        else
            @manufacturers = Manufacturer.all
            @car_categories = CarCategory.all
            render :new
        end
    end

    private

    def car_model_params
        params.require(:car_model).permit(:name,:year,:manufacturer_id,:motorization,
                                    :car_category_id,:fuel_type)
    end
end