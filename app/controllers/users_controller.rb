class UsersController < ApplicationController
 
before_action :admin_user, only: :destroy





	def show
	@user=User.find(params[:id])
	
	end 
 
 
  def new
  @user=User.new
  end
  
  def create
  @user=User.new(user_params)
  if @user.save
  name=@user.name
  flash[:success]="Welcome #{name}";
  log_in @user
  redirect_to @user
  else
  render 'new'
  end
  end
  

  def edit
  	@user=User.find(params[:id])

  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash.now[:success]="Profile Updated"
      render 'show'
    else

      render 'edit'
    end
  end

  def destroy
    @user=User.find(params[:id]).destroy
    flash[:success]="#{@user.name} Deleted"
    redirect_to users_url
  end

  def index
    @users=User.all
  end
  private
  
  def user_params
  params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
  def admin_user
    if current_user.admin?
      current_user
    else
      flash[:danger]="Not an admin"
      redirect_to root_url
    end
  end
end
