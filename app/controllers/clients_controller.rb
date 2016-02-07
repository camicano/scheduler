class ClientsController < ApplicationController
  before_action :current_user, only: :show

  def new
    if cookies[:user]
      redirect_to action: "show", id: cookies[:user]
    else
      @client = Client.new
    end
  end

  def create
    @client = Client.new(client_params)
    @client.coach = Coach.find(1 + Random.rand(Coach.all.length))

    respond_to do |format|
      if @client.save
        cookies[:user] = @client.id
        
        format.html do
          redirect_to action: "show", id: @client.id
        end
      else
        format.html { render :new }
      end
    end
  end

  def show
    @months = get_list_of_months
    @client
  end

  private
  def client_params
    params.permit(:name)
  end

  def current_user
    if cookies[:user]
      @client = Client.find cookies[:user]
    end
  end

  def get_list_of_months
    Date::ABBR_MONTHNAMES.compact.each_with_index.collect{ |month, index| [month, index + 1] }.insert(0, ['Please Select', nil])
  end
end