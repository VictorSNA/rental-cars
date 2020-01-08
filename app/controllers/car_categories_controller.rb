class CarCategoriesController < ApplicationController
    def index
        @carcategories = CarCategory.all
    end

    def show
        @carcategory = CarCategory.find(params[:id])
    end

    def new
        @carcategory = CarCategory.new
    end

    def create
        @carcategory = CarCategory.new(carcategoryparams)

        if @carcategory.save
            redirect_to @carcategory
        else
            render :new
        end
    end
    
    def edit
        @carcategory = CarCategory.find(params[:id])
    end

    def update
        @carcategory = CarCategory.find(params[:id])

        if @carcategory.update(carcategoryparams)
            flash[:alert] = 'Editado com sucesso'
            redirect_to @carcategory
        else
            render :edit
        end
    end

    def destroy
        @carcategory = CarCategory.find(params[:id])

        if @carcategory.destroy
            flash[:alert] = 'Excluído com sucesso'
            redirect_to car_categories_path
        else
            redirect_to :show
        end
    end
    private

    def carcategoryparams
        params.require(:car_category).permit(:name,:daily_rate,:car_insurance,:third_party_insurance)
    end
end