require './config/environment'

class ApplicationController < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  register Sinatra::ActiveRecordExtension
  set :session_secret, "youll_never_get_my_a**"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/index" do
    if logged_in?
      @user = current_user
      @setups = Setup.all
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
