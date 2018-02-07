class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_tweet, only:  [:show, :destroy]


  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      flash[:notice] = "Tweet was successfully created"
      redirect_to admin_tweets_path
    else
      flash.now[:alert] = "Tweet was failed to create"
      render :new
    end
  end

  def destroy
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "This tweet was deleted"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
