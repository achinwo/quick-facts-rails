class UsersController < ApplicationController

  before_action :check_admin, only: [:index]
  
  def index
  end

  def new
  	@user = User.new
  end

  def create
    puts "PARAMS= #{params}"
  	@user = User.new(user_params)
  	@user.save
    @user.send_account_activation_email if @user.persisted?

    respond_to do |format|
      format.json do
        if @user.persisted?
          render json: @user
        else
          puts "Sending error response: #{@user.errors.full_messages}"
          render json: {errors: @user.errors}, status: :not_acceptable, layout: false
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
          render json: user
        else
          render file: "public/422.html", status: :unauthorized, layout: false
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
