class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.order(:email)
  end

  def show
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

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    if @user.update(user_params)
      flash[:notice] = "User successfully updated."
      redirect_to admin_user_path(@user)
    else
      flash[:alert] = "User could not be updated."
      render action: "edit"
    end
  end

  def destroy
    if @user == current_user
      flash[:alert] = "You cannot delete yourself!"
      redirect_to admin_users_path
    elsif @user.destroy
      flash[:notice] = "User has been deleted."
      redirect_to admin_users_path
    else
      flash[:alert] = "User could not be deleted."
      redirect_to admin_user_path(@user)
    end
  end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:firstname,
                                   :lastname,
                                   :email,
                                   :password,
                                   :password_confirmation,
                                   :admin)
    end
end
