class UsersController < ApplicationController

  before_action :check_admin, only: [:index]
  
  def index
  end

  def new
  	@user = User.new
  end

  def send_message
    require "google/api_client"
    Rails.logger.info "Lookup book details for"

    # Create Books API client
    api_client = Google::APIClient.new application_name: "Bookshelf Sample Application"
    api_client.authorization = nil # Books API does not require authorization
    books_api = api_client.discovered_api "books"

    result = api_client.execute(
        api_method: books_api.volumes.list,
        parameters: { q: "Treasury Island", order_by: "relevance" } # what is the default order?  can we leave off "relevance" and get consistently good results?
    )

    # Lookup a list of relevant books based on the provided book title.
    volumes = result.data.items

    render json: {message: volumes}
  end

  def create
    puts "PARAMS= #{params}"
  	@user = User.new(user_params)
  	@user.save
    @user.send_account_activation_email if @user.persisted?

    respond_to do |format|
      format.json do
        if @user.persisted?
          render json: {user: @user}
        else
          puts "Sending error response: #{@user.errors.full_messages}"
          render json: {errors: @user.errors}
        end
      end

      format.html do
          if @user.persisted?
            message = "Account activation instructions have sent to #{@user.email}. "
            message += "<a href='#{new_account_activation_url(email: @user.email)}'>Re-send?</a>"
            flash[:success] = message
            redirect_to root_url
          else
            render 'new'
          end
      end
  	end
  end

  def authenticate
    password = params[:password]
    email = params[:email]

    user = User.find_by(email: email)

    respond_to do |format|
      format.json do
        if user && user.authenticate(password)
          render json: {user: user}
        else
          render json: {errors: {password: ["Password is invalid"]}}
        end
      end
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def check_admin
      redirect_to root_url unless current_user && current_user.admin
    end
end
