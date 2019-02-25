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
      @user = current_user
      @setups = Setup.all
      if @setups.first.nil?
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
  end

end
