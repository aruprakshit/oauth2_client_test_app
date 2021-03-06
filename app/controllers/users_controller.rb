class UsersController < AuthenticationsController
  before_action :require_login, only: [:index]
  before_action :check_shutdown

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)

      flash[:success] = 'Welcome!'

      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
