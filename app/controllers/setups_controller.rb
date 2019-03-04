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
    @user = current_user

    if logged_in? && @user.setup.nil?
      erb :"/setups/new.html"
    else
      flash[:message_edit] = "A user may only have one setup"
      redirect "/setups/#{@user.setup.id}"
    end
  end

  # POST: /setups
  post "/setups" do
    if logged_in?
      setup = Setup.create
      setup.name = params[:setup][:name]
      setup.rank = params[:setup][:rank]

      # Save images dynamically
      filenames = []
      files = []

      if !params[:file].nil?
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
          setup.send("image#{i+1}=", "/images/#{filename}")
        end
      end

      setup.save
      setup.user_id = current_user.id

      redirect "/setups/#{setup.id}"
    else
      flash[:message_edit] = "Only a page owner can edit thier page"
      redirect "/setups/#{params[:id]}"
    end
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
    @user = current_user
    @setup = Setup.find(params[:id])

    erb :"/setups/edit.html"
  end

  # PATCH: /setups/5
  patch "/setups/:id" do
    setup = Setup.find(params[:id])
    if logged_in?
      setup.name = params[:setup][:name]
      setup.rank = params[:setup][:rank]
      # Save images dynamically
      filenames = []
      files = []

      if !params[:file].nil?
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
          setup.send("image#{i+1}=", "/images/#{filename}")
        end
      end

      setup.save

      redirect "/setups/#{setup.id}"
    else
      flash[:message_edit] = "Only a page owner can edit thier page"
      redirect "/setups/#{params[:id]}"
    end
  end

  # DELETE: /setups/5/delete
  delete "/setups/:id/delete" do
    redirect "/setups"
  end
end
