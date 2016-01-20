class FeedsController < ApplicationController
  http_basic_authenticate_with name: "bon", password: "bon", except: [:index]
  BIG_BANG = DateTime.new(2016, 1, 1, 0, 0, 0)
  
  def index
    x = Time.current.change(hour: 6)
    feed_since = (x > Time.current) ? x-1.day : x
    @feed = Feed.last
    @feed = Feed.new if @feed.duration
    seconds = Feed.sum(:duration)+35*3600
    @today = Feed.where("created_at>?", feed_since).sum(:duration)/60
    age = Time.now - BIG_BANG
    time_to_junior = 500*3600
    @percentage = seconds *100 / time_to_junior
    speed = seconds / age 
    @estimated_junior_milestone = BIG_BANG.in((time_to_junior / speed).to_i).to_formatted_s(:long) 
    @estimated_senior_milestone = BIG_BANG.in((time_to_junior * 2 / speed).to_i).to_formatted_s(:long)
    @hours_left_to_junior = (time_to_junior - seconds) / 3600
    @hours_left_to_senior = (time_to_junior * 2 - seconds) / 3600
  end

  def update
    @feed = Feed.last
    @feed = Feed.create if @feed.duration 
    if @feed.start
      @feed.update_attributes(duration: Time.now-@feed.start)
    else 
      @feed.update_attributes(start: Time.now)
    end
   redirect_to root_path
   end
end
