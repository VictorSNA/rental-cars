class SubsidiariesController < ApplicationController
  before_action :authenticate_user!, only: %i[index show new edit]
  before_action :set_subsidiary, only: %i[show edit update destroy]

  def index
    return @subsidiaries = Subsidiary.all if current_user.admin?

    @subsidiaries = Subsidiary.where(id: current_user.subsidiary)
  end

  def show
    return redirect_to root_path, alert: 'Você não pode fazer essa ação' \
      unless current_user.subsidiary == @subsidiary || current_user.admin?
  end

  def new
    return redirect_to root_path, alert: 'Você não pode fazer essa ação' \
      unless current_user.admin?
    @subsidiary = Subsidiary.new
  end

  def edit
    return redirect_to root_path, alert: 'Você não pode fazer essa ação' \
      unless current_user.admin?
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
    if current_user.admin? && current_user.subsidiary = @subsidiary
      return redirect_to subsidiaries_path, notice: 'Filial excluída com sucesso'\
        if @subsidiary.destroy

      redirect_to :show
    end
  end

  private

  def set_subsidiary
    @subsidiary = Subsidiary.find(params[:id])
  end

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end
end
