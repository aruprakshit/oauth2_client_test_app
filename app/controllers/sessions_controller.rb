class SessionsController < AuthenticationsController
  def new
  end

  def create
    if login(params[:email], params[:password])
      flash[:success] = 'Welcome back!'
      redirect_to root_path
    else
      flash.now[:warning] = 'E-mail and/or password is incorrect.'
      render 'new'
    end
  end

  def destroy
    logout

    flash[:success] = 'See you!'
    redirect_to log_in_path
  end
end
