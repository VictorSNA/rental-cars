class SubsidiariesController < ApplicationController
    before_action :authenticate_user!, only:[:index, :show, :new, :edit]
    before_action :set_subsidiary, only:[:show, :edit, :update, :destroy]
    def index
        @subsidiaries = Subsidiary.all
    end
    def show
    end
    def new
        @subsidiary = Subsidiary.new
    end
    def edit
    end
    def update
        if @subsidiary.update(subsidiary_params)
            redirect_to @subsidiary
        else
            render :edit
        end
    end

    def create
        @subsidiary = Subsidiary.new(subsidiary_params)

        if @subsidiary.save
            redirect_to @subsidiary, notice: 'Filial registrada com sucesso'
        else
            render :new
        end
    end

    def destroy
        return redirect_to subsidiaries_path,
            notice: 'Filial excluída com sucesso' if @subsidiary.destroy
        
        redirect_to :show
    end
    private
    def set_subsidiary
        @subsidiary = Subsidiary.find(params[:id])
    end
    def subsidiary_params
        params.require(:subsidiary).permit(:name, :cnpj, :address)
    end
end