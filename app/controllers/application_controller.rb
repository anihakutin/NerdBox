require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
    register Sinatra::ActiveRecordExtension
    enable :sessions
    set :session_secret, "youll_never_get_my_a**"
    set :method_override, true
  end

  get "/" do
    if logged_in?
      # binding.pry
      @user = current_user
      @all = [ ]
      User.all.each { |e| @all << e }
      Resource.all.each { |e| @all << e }
      Hardware.all.each { |e| @all << e }
      Setup.all.each { |e| @all << e }
      @all = sort_by_date(@all)
      if @all.first.nil?
        flash[:message_index] = "Much empty here..."
      end
      erb :index
    else
      redirect "/users/login"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def sort_by_date(arr)
      arr.sort_by { |h| h["created_at"].to_s.split('/').reverse }
    end
  end

end
