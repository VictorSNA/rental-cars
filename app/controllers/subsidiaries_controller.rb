class SubsidiariesController < ApplicationController
    def index
        @subsidiaries = Subsidiary.all
    end

    def show
        @subsidiary = Subsidiary.find(params[:id])
    end
    
    def new
        @subsidiary = Subsidiary.new
    end

    def edit
        @subsidiary = Subsidiary.find(params[:id])
    end

    def update
        @subsidiary = Subsidiary.find(params[:id])
        if @subsidiary.update(subsidiary_params)
            redirect_to @subsidiary
        else
            render :edit
        end
    end

    def create
        @subsidiary = Subsidiary.new(subsidiary_params)

        if @subsidiary.save
            redirect_to @subsidiary
        else
            render :new
        end
    end

    def destroy
        @subsidiary = Subsidiary.find(params[:id])
        if @subsidiary.destroy
            flash[:notice] = "Filial excluída com sucesso"
            redirect_to subsidiaries_path
        else
            redirect_to :show
        end
    end
    private

    def subsidiary_params
        params.require(:subsidiary).permit(:name, :cnpj, :address)
    end
end