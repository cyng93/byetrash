class WastesController < ApplicationController

  def index
    @wastes = Waste.all
    @waste = Waste.new
  end

  def show
    @waste = Waste.find(params[:id])
  end

  def new
    @waste = Waste.new
  end

  def edit
    @waste = Waste.find(params[:id])
  end

  def create
    @waste = Waste.new(waste_params)

    if @waste.save
      redirect_to waste_path(@waste)
    else
      render 'new'
    end
  end

  def update
    @waste = Waste.find(params[:id])

    old_weight = @waste.weight
    new_weight = waste_params[:weight].to_f

    if @waste.update(waste_params)
      # check if we need to re-adjust user's score(waste's weight changed)
      if new_weight != old_weight
        counts = {}
        @waste.thrown_wastes.each do |thrown|
          if !counts.key?(thrown.user)
            counts[thrown.user] = 1
          else
            counts[thrown.user] += 1
          end
        end

        new_scores = {}
        counts.each do |user, count|
          new_scores[user] = user.score - (old_weight * count) + (new_weight * count)
          new_scores[user] = 0 if new_scores[user] < 0
        end

        new_scores.each do |user, new_score|
          user.update_score(new_score)
        end
      end
      redirect_to @waste
    else
      render 'edit'
    end
  end

  def destroy
    @waste = Waste.find(params[:id])

    # re-adjusting user's score as waste are removed.
    counts = {}
    @waste.thrown_wastes.each do |thrown|
      if !counts.key?(thrown.user)
        counts[thrown.user] = 1
      else
        counts[thrown.user] += 1
      end
    end

    new_scores = {}
    counts.each do |user, count|
      new_scores[user] = user.score - (@waste.weight * count)
      new_scores[user] = 0 if new_scores[user] < 0
    end

    new_scores.each do |user, new_score|
      user.update_score(new_score)
    end

    @waste.destroy

    redirect_to wastes_path
  end


private
  def waste_params
    params.require(:waste).permit(:name,
                                  :description,
                                  :image_name,
                                  :weight)
  end
end
