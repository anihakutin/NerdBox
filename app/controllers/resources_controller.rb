class ResourcesController < ApplicationController

  # GET: /resources
  get "/resources" do
    if logged_in?
      @user = current_user
      @resources = Resource.all

      erb :"/resources/index.html"
    else
      redirect "/users/login"
    end
  end

  # GET: /resources/new
  get "/resources/new" do
    @user = current_user

    erb :"/resources/new.html"
  end

  # POST: /resources
  post "/resources" do
    if logged_in?
      # Save images
      filename = params[:file][:filename]
      file = params[:file][:tempfile]

      File.open("./public/images/#{filename}", 'wb') do |f|
        f.write(file.read)
      end

      resource = Resource.create
      # Update icon
      resource.icon = "/images/#{filename}"
      # Update Hardware
      resource.name = params[:resource][:name]
      resource.link = params[:resource][:name]
      resource.rank = params[:resource][:rank]
      resource.save

      current_user.resources << resource

      redirect "/resources/#{resource.id}"
    else
      flash[:message_edit] = "You must be logged in to create a resource"
      redirect "/resources/#{params[:id]}"
    end
    redirect "/resources"
  end

  # GET: /resources/5
  get "/resources/:id" do
    @user = current_user
    @resource = Resource.find(params[:id])

    erb :"/resources/show.html"
  end

  # GET: /resources/5/edit
  get "/resources/:id/edit" do
    @user = current_user
    @resource = Resource.find(params[:id])

    erb :"/resources/edit.html"
  end

  # PATCH: /resources/5
  patch "/resources/:id" do
    resource = Resource.find(params[:id])

    if logged_in? && current_user.resources.include?(resource)
      # Save images
      filename = params[:file][:filename]
      file = params[:file][:tempfile]

      File.open("./public/images/#{filename}", 'wb') do |f|
        f.write(file.read)
      end

      # Update icon
      resource.icon = "/images/#{filename}"
      # Update Hardware
      resource.name = params[:resource][:name]
      resource.link = params[:resource][:name]
      resource.rank = params[:resource][:rank]
      resource.save

      current_user.resources << resource

      redirect "/resources/#{resource.id}"
    else
      flash[:message_edit] = "Only a page owner can edit thier page"
      redirect "/resources/#{params[:id]}"
    end
  end

  # DELETE: /resources/5/delete
  delete "/resources/:id/delete" do
    redirect "/resources"
  end
end
