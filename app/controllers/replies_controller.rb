class RepliesController < ApplicationController
  after_action :update_count , only: :create

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @user = @tweet.user
    @replies = @tweet.replies.all
    @reply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save
    redirect_to tweet_replies_path(@tweet)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

  def update_count
    @tweet.update_count
  end

end
