class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(:email)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User successfully created."
      redirect_to admin_users_path
    else
      flash[:alert] = "User could not be created."
      render action: 'new'
    end
  end


  private
    def user_params
      params.require(:user).permit(:firstname,
                                   :lastname,
                                   :email,
                                   :password,
                                   :password_confirmation,
                                   :admin)
    end
end
