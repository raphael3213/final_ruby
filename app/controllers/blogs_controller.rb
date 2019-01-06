class BlogsController < ApplicationController

before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@blog=current_user.blogs.build(blogs_params)
		if @blog.save
			flash[:success] = "Blog created!"
			redirect_to root_url
		else
			render 'static_page/home'
		end
	end


	def edit
		@blog=current_user.blogs.find_by(id:params[:id])
	end

	def update
		@user=current_user
		@blog=@user.blogs.find_by(id:params[:id])
		if @blog.update_attributes(blogs_params)
			flash[:success] = "Blog updated"
redirect_to root_url

		else
			flash[:danger] = "Updating failed"
			redirect_to root_url
		end
	end

	def destroy
		@blog.destroy
	flash[:success] = "Blog deleted"
redirect_to request.referrer || root_url
	end






def correct_user
@blog = current_user.blogs.find_by(id: params[:id])
redirect_to root_url if @blog.nil?
end




	 

  private

  def blogs_params
  params.require(:blog).permit(:title,:content)
  end

  def logged_in_user
    if !logged_in?
      flash[:danger]="Please Log in"
      redirect_to root_url
    end
  end
end
