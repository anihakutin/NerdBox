class HardwaresController < ApplicationController

  # GET: /hardwares
  get "/hardwares" do
    if logged_in?
      @user = current_user
      @hardwares = Hardware.all

      erb :"/hardwares/index.html"
    else
      redirect "/users/login"
    end
  end

  # GET: /hardwares/new
  get "/hardwares/new" do
    @user = current_user
    erb :"/hardwares/new.html"
  end

  # POST: /hardwares
  post "/hardwares" do
    if logged_in?

      # Update Hardware
      hardware = Hardware.create
      hardware.name = params[:hardware][:name]
      hardware.rank = params[:hardware][:rank]

      # Save images dynamically
      if !params[:file].nil?
        filenames = []
        files = []

        params[:file].each do |i|
          filenames << i[1][:filename]
          files << i[1][:tempfile]
        end

        files.each_with_index do |file, i|
          File.open("./public/images/#{filenames[i]}", 'wb') do |f|
            f.write(file.read)
          end
        end

        # Update images dynamically
        filenames.each_with_index do |filename, i|
          hardware.send("image#{i+1}=", "/images/#{filename}")
        end
      end

      hardware.save

      if params[:hardware][:hardware] == current_user.slug
        current_user.hardwares << hardware
      else
        current_user.setup.hardwares << hardware
      end

      redirect "/hardwares/#{hardware.id}"
    else
      flash[:message_edit] = "Only a page owner can edit thier page"
      redirect "/hardwares/#{params[:id]}"
    end
  end

  # GET: /hardwares/5
  get "/hardwares/:id" do
    @user = current_user
    @hardware = Hardware.find(params[:id])

    erb :"/hardwares/show.html"
  end

  # GET: /hardwares/5/edit
  get "/hardwares/:id/edit" do
    @hardware = Hardware.find(params[:id])
    if logged_in?
      @user = current_user
      erb :"/hardwares/edit.html"
    else
      flash[:message_edit] = "Only a page owner can edit thier page"
      redirect "/hardwares/#{params[:id]}"
    end
  end

  # PATCH: /hardwares/5
  patch "/hardwares/:id" do
    hardware = Hardware.find(params[:id])
    if logged_in?
      # Save images dynamically
      if !params[:file].nil?
        filenames = []
        files = []

        params[:file].each do |i|
          filenames << i[1][:filename]
          files << i[1][:tempfile]
        end

        files.each_with_index do |file, i|
          File.open("./public/images/#{filenames[i]}", 'wb') do |f|
            f.write(file.read)
          end
        end

        # Update images dynamically
        filenames.each_with_index do |filename, i|
          hardware.send("image#{i+1}=", "/images/#{filename}")
        end
      end

      # Update Hardware
      hardware.name = params[:hardware][:name]
      hardware.rank = params[:hardware][:rank]
      hardware.save

      redirect "/hardwares/#{hardware.id}"
    else
      flash[:message_edit] = "Only a page owner can edit thier page"
      redirect "/hardwares/#{params[:id]}"
    end
  end

  # DELETE: /hardwares/5/delete
  delete "/hardwares/:id/delete" do
    hardware = Hardware.find(params[:id])
    hardware.destroy

    redirect "/hardwares"
  end
end
