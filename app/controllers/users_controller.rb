class UsersController < ApplicationController

  def show
    @row_count = {}
    @last_col_count = {}
    @trash_per_day = (current_user.score_week1+current_user.score_week2)/day_passed/50.0
    @row_count['day'] = (@trash_per_day/2).round
    @row_count['month'] = ((@trash_per_day*30).round/3).round
    @row_count['year'] = ((@trash_per_day*365).round/6).round
    @last_col_count['day'] = (@trash_per_day%2).round
    @last_col_count['month'] = ((@trash_per_day*30).round%3).round
    @last_col_count['year'] = ((@trash_per_day*365).round%6).round
  end

  def index
    @users = User.all
    @user = User.new
  end

  def new
    if current_user
      flash[:message] = 'Welcome back, ' + current_user.username + '!'
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    need_logout = true  if @user == current_user  # need logout if user is
                                                  #   destroying itself
    @user.destroy
    if need_logout
      redirect_to logout_path
    else
      redirect_to users_path
    end

  end

private
  def user_params
    params.require(:user).permit(:username,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :is_admin
                                 )
  end
end
