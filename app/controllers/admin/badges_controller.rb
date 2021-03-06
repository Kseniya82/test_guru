class Admin::BadgesController < ApplicationController
  before_action :find_badge, only: [:show, :edit, :update, :destroy]

  def index
    @badges = Badge.all
  end

  def show;  end

  def new
    @badge = Badge.new
  end


  def edit;  end

  def create
    @badge = Badge.new(badge_params)
    if @badge.save
      redirect_to [:admin,@badge], notice: 'Badge was successfully created.'
    else
     render :new
    end
  end

  def update
    if @badge.update(badge_params)
      redirect_to [:admin,@badge], notice: 'Badge was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_url, notice: 'Badge was successfully destroyed.'
  end

  private

    def find_badge
      @badge = Badge.find(params[:id])
    end

    def badge_params
      params.require(:badge).permit(:title, :url, :rule_name, :rule_value)
    end
end
