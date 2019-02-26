class HardwaresController < ApplicationController

  # GET: /hardwares
  get "/hardwares" do
    erb :"/hardwares/index.html"
  end

  # GET: /hardwares/new
  get "/hardwares/new" do
    erb :"/hardwares/new.html"
  end

  # POST: /hardwares
  post "/hardwares" do
    redirect "/hardwares"
  end

  # GET: /hardwares/5
  get "/hardwares/:id" do
    @user = current_user
    @user_show = User.find_by_slug(params[:slug])
    
    erb :"/hardwares/show.html"
  end

  # GET: /hardwares/5/edit
  get "/hardwares/:id/edit" do
    erb :"/hardwares/edit.html"
  end

  # PATCH: /hardwares/5
  patch "/hardwares/:id" do
    redirect "/hardwares/:id"
  end

  # DELETE: /hardwares/5/delete
  delete "/hardwares/:id/delete" do
    redirect "/hardwares"
  end
end
