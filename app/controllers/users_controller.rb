class UsersController < ApplicationController
 
before_action :admin_user, only: :destroy
before_action :logged_in_user, only: [:edit,:update] 
before_action :correct_user, only: [:edit,:update]



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

      if  @user.update_attributes(user_params)
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
  params.require(:user).permit(:name,:email,:password,:password_confirmation,:image)
  end

  

  
  def admin_user

    if current_user.nil?
      flash[:danger]="Please Log in"
      redirect_to root_url
      
    
  else
    if current_user.admin?
      current_user
    else
      flash[:danger]="Not an admin"
      redirect_to root_url
    end
  end
  end


  def logged_in_user
    if !logged_in?
      flash[:danger]="Please Log in"
      redirect_to root_url
    end
  end


  def correct_user
    @id_access=params[:id]
    @id_curr=current_user.id

    if @id_access != @id_curr
      flash[:danger]="Access Restricted"
      redirect_to root_url
    end
  end
end
