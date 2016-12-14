class ThrownWastesController < ApplicationController
  before_action :require_login

  def index
    @user = User.find(params[:user_id])
    @thrown_waste = ThrownWaste.new
    @thrown_wastes = @user.thrown_wastes.all
  end

  def new
    @user = User.find(params[:user_id])
  end

  def eat
    @user = User.find(params[:user_id])
    @category = 'eat'
    @waste = Waste.where(category: @category)
    render 'new'
  end

  def drink
    @user = User.find(params[:user_id])
    @category = 'drink'
    @waste = Waste.where(category: @category)
    render 'new'
  end

  def wrapping
    @user = User.find(params[:user_id])
    @category = 'wrapping'
    @waste = Waste.where(category: @category)
    render 'new'
  end

  def paper
    @user = User.find(params[:user_id])
    @category = 'paper'
    @waste = Waste.where(category: @category)
    render 'new'
  end

  def create
    @user = User.find(params[:user_id])
    @thrown_waste = @user.thrown_wastes.new(thrown_waste_params)

    respond_to do |f|
      if @thrown_waste.save
        new_score = current_user.get_score() + @thrown_waste.waste.weight
        current_user.update_score(new_score)
        f.html {
          redirect_to new_user_thrown_waste_path(current_user)
        }
        f.js {}
      else
        f.html {
          render 'new'
        }
        f.js { render status: 500 }
      end

    end
  end

  def destroy
    @thrown_waste = current_user.thrown_wastes.find(params[:id])
    new_score = current_user.get_score - @thrown_waste.waste.weight
    new_score = 0 if new_score < 0

    respond_to do |f|
      if @thrown_waste.destroy
        current_user.update_score(new_score)
        f.html {
          redirect_to user_thrown_wastes_path(current_user)
        }
        f.js {}
      else
        f.html {
          render 'index'
        }
        f.js { render status: 500 }
      end
    end
  end

  def statistic
    @user = User.find(params[:user_id])
  end

  def reduction
    @user = User.find(params[:user_id])
  end

private
  def thrown_waste_params
    params.require(:thrown_waste).permit(:user_id,
                                         :waste_id
                                         )
  end

  def require_login
    if !current_user
      flash[:message] = 'Login to continue...'
      redirect_to login_path
    end
  end
end
