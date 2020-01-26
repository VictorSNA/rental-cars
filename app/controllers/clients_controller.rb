class ClientsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :show]
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  def index
    @clients = Client.all
  end
  def show
  end
  def new
    @client = Client.new
  end
  def edit
  end
  def create
    @client = Client.new(client_params)
    return redirect_to @client,
          notice: 'Cliente registrado com sucesso'if @client.save
    
    render :new
  end
  def update
    return redirect_to @client,
          notice: 'Cliente editado com sucesso'if @client.update(client_params)
    
    render :edit
  end
  def destroy
    return redirect_to clients_path,
      notice: 'Cliente excluído com sucesso' if @client.destroy

    redirect_to @client
  end
  private
  def set_client
    @client = Client.find(params[:id])
  end
  def client_params
    params.require(:client).permit(:name, :cpf, :email)
  end
end