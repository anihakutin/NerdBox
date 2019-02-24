class UsersController < ApplicationController

  get "/users/signup" do
    flash[:message_signup] = ""
    erb :"/users/login.html"
  end

  post "/signup" do
    if params[:user][:username].empty? || params[:user][:email].empty? || params[:user][:password].empty?
      flash[:message_signup] = "Fields Cannot Be Empty"
      erb :"/users/login.html"
    else
      if User.find_by_email(params[:user][:email]) || User.find_by_username(params[:user][:username])
        flash[:message_signup] = "Email Is Already Taken"
        erb :"/users/login.html"
      else
        user = User.new(params[:user])
        if user.save
          session[:user_id] = user.id
          redirect "/index"
        else
          flash[:message_signup] = "Signup Error, Please Try Again Later"
          erb :"/users/login.html"
        end
      end
    end
  end

  get "/users/login" do
    if logged_in?
      redirect "/index"
    else
      erb :"/users/login.html"
    end
  end

  post "/login" do
    user = User.find_by_username(params[:user][:username])

    if !user && user.authenticate(params[:user][:password])
      flash[:message_login] = "Username or Password is incorrect"
      erb :"/users/login.html"
    else
      session[:user_id] = user.id
      redirect "/index"
    end
  end

  get '/users/logout' do
    session.clear
    redirect "/users/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end

end
