class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def show
    @user = User.find(params[:id])
    @row_count = {}
    @last_col_count = {}
    @trash_per_day = (@user.score_week1 + @user.score_week2)/day_passed/50.0
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
      @user.update!(is_admin: true) if @user.id == 1
      session[:user_id] = @user.id
      cookies.encrypted[:user_id] = { value: @user.id,
                                      expires: 1.year.from_now }
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

    if @user.update(update_user_params)
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
                                 :password,
                                 :password_confirmation,
                                 )
  end

  def update_user_params
    params.require(:user).permit(:username,
                                 :is_admin,
                                 :score_week1,
                                 :score_week2
                                 )
  end
end
