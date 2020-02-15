class SubsidiariesController < ApplicationController
  before_action :authenticate_user!, only: %i[index show new edit]
  before_action :set_subsidiary, only: %i[show edit update destroy]

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
    return redirect_to @subsidiary if @subsidiary.update(subsidiary_params)

    render :edit
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    return redirect_to @subsidiary, notice: 'Filial registrada com sucesso'\
      if @subsidiary.save

    render :new
  end

  def destroy
    return redirect_to subsidiaries_path, notice: 'Filial excluída com sucesso'\
      if @subsidiary.destroy

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
