class ConclusionController < ApplicationController
  def index
    @user = current_user
    @week1_trash = @user.score_week1
    @week2_trash = @user.score_week2
    if @week1_trash > @week2_trash
      @reduce_percent = (@week1_trash - @week2_trash)/(@week1_trash*1.0)*100
    else
      @reduce_percent = (@week2_trash - @week1_trash)/(@week1_trash*1.0)*100
    end
  end
end

