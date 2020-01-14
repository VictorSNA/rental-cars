class ClientsController < ApplicationController
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

  private

  def client_params
    params.require(:client).permit(:name, :cpf, :email)
  end
end