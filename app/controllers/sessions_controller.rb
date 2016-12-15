class SessionsController < ApplicationController
  def new
    if current_user
      flash[:message] = 'Welcome back, ' + current_user.username + '!'
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    # If the user exists AND the password entered is correct.
    if @user && @user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = @user.id
      cookies.encrypted[:user_id] = { value: @user.id,
                                      expires: 1.year.from_now }
      flash[:message] = 'Welcome back, ' + @user.username + ' :)'
      redirect_to '/'
    else
      # If user's login doesn't work, send them back to the login form.
      flash[:message] = 'Invalid username or password!'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete :user_id
    redirect_to '/login'
  end
end
