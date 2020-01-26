class ClientsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :show]
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def show
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(client_params)
    return redirect_to @client,
          notice: 'Registrado com sucesso'if @client.save
    
    render :new
  end

  def destroy
    @client = Client.find(params[:id])

    return redirect_to clients_path,
      notice: 'Cliente excluído com sucesso' if @client.destroy

    redirect_to @client
  end
  private

  def client_params
    params.require(:client).permit(:name, :cpf, :email)
  end
end