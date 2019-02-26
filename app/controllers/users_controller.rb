class UsersController < ApplicationController

  get "/users/signup" do
    flash[:message_signup] = ""
    erb :"/users/login.html"
  end

  post "/signup" do
    if params[:user][:username].empty? || params[:user][:email].empty? || params[:user][:password].empty?
      flash[:message_signup] = "Fields Cannot Be Empty"
      redirect "/users/login"
    else
      if User.find_by_email(params[:user][:email]) || User.find_by_username(params[:user][:username])
        flash[:message_signup] = "Email Is Already Taken"
        redirect "/users/login"
      else
        user = User.new(params[:user])
        if user.save
          session[:user_id] = user.id
          redirect "/"
        else
          flash[:message_signup] = "Signup Error, Please Try Again Later"
          redirect "/users/login"
        end
      end
    end
  end

  get "/users/login" do
    if logged_in?
      redirect "/"
    else
      erb :"/users/login.html"
    end
  end

  post "/login" do
    user = User.find_by_username(params[:user][:username])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect "/"
    else
      flash[:message_login] = "Username or Password is incorrect"
      redirect "/users/login"
    end
  end

  get "/users/logout" do
    session.clear
    redirect "/users/login"
  end

  # Show - public
  get "/users/:slug" do
    @user = current_user
    @user_show = User.find_by_slug(params[:slug])
    erb :"/users/show.html"
  end

  # Show - Edit - Private
  get "/users/:slug/edit" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])

      erb :"/users/edit.html"
    else
      redirect "/users/login"
    end
  end

  patch "/users/:id" do
    user = User.find(params[:id])
    if logged_in?
      if user && user.authenticate(params[:user][:password_current])
        user.username = params[:user][:username]
        user.email = params[:user][:email]
        user.password = params[:user][:password_new] unless params[:user][:password_new].empty?
        user.save
        flash[:message_edit] = "Changes saved!"
        redirect "/users/#{user.slug}/edit"
      else
        user = User.find(params[:id])
        flash[:message_edit] = "Please enter current password to make changes to your profile"

        redirect "/users/#{user.slug}/edit"
      end
    else
      redirect "/users/login"
    end
  end

  delete "/users/:id/delete" do
    user = User.find_by_id(params[:id])
    if user && user.authenticate(params[:user][:password_current])
      user.destroy
      session.clear
      redirect "/users/login"
    else
      flash[:message_edit] = "Incorrect Username Or Password"
      redirect "/users/#{user.slug}/edit"
    end
  end


end
