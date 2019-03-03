class SetupsController < ApplicationController

  # GET: /setups
  get "/setups" do
    if logged_in?
      @user = current_user
      @setups = Setup.all

      erb :"/setups/index.html"
    else
      redirect "/users/login"
    end
  end

  # GET: /setups/new
  get "/setups/new" do
    erb :"/setups/new.html"
  end

  # POST: /setups
  post "/setups" do
    redirect "/setups"
  end

  # GET: /setups/5
  get "/setups/:id" do
    @user = current_user
    @setup = Setup.find(params[:id])

    erb :"/setups/show.html"
  end

  # GET: /setups/5/edit
  get "/setups/:id/edit" do
    erb :"/setups/edit.html"
  end

  # PATCH: /setups/5
  patch "/setups/:id" do
    redirect "/setups/:id"
  end

  # DELETE: /setups/5/delete
  delete "/setups/:id/delete" do
    redirect "/setups"
  end
end
