class TestsController < ApplicationController
  before_action :find_test, only: [:show, :update, :destroy, :edit, :start]
  before_action :set_user, only: :start

  def index
    @tests = Test.all
  end

  def edit; end

  def show
    @questions = @test.questions
  end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to test_path(@test)
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def start
    @user.tests.push(@test)
    redirect_to @user.test_passage(@test)
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :user_id)
  end

  def set_user
    @user = User.first
  end
end