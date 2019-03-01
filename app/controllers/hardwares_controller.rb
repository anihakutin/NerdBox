class HardwaresController < ApplicationController

  # GET: /hardwares
  get "/hardwares" do
    @user = current_user
    @hardwares = Hardware.all

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
    @hardware = Hardware.find(params[:id])

    erb :"/hardwares/show.html"
  end

  # GET: /hardwares/5/edit
  get "/hardwares/:id/edit" do
    # .hardwareable.is_a?(User)
    @hardware = Hardware.find(params[:id])
    if logged_in? && @hardware.hardwareable.id == current_user.id
      @user = current_user
      erb :"/hardwares/edit.html"
    else
      flash[:message_edit] = "Only a page owner can edit thier page"
      redirect "/hardwares/#{params[:id]}"
    end
  end

  # PATCH: /hardwares/5
  patch "/hardwares/:id" do

    # Save image
    @filename = params[:file][:filename]
    file = params[:file][:tempfile]

    File.open("./public/images/#{@filename}", 'wb') do |f|
      f.write(file.read)
    end

    # Update Hardware
    hardware = Hardware.find(params[:id])
    hardware.name = params[:hardware][:name]
    hardware.rank = params[:hardware][:rank]
    hardware.image1 = "/images/#{@filename}"
    hardware.save

    redirect "/hardwares/#{hardware.id}"
  end

  # DELETE: /hardwares/5/delete
  delete "/hardwares/:id/delete" do
    redirect "/hardwares"
  end
end
