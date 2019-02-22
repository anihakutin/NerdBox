class ResourcesController < ApplicationController

  # GET: /resources
  get "/resources" do
    erb :"/resources/index.html"
  end

  # GET: /resources/new
  get "/resources/new" do
    erb :"/resources/new.html"
  end

  # POST: /resources
  post "/resources" do
    redirect "/resources"
  end

  # GET: /resources/5
  get "/resources/:id" do
    erb :"/resources/show.html"
  end

  # GET: /resources/5/edit
  get "/resources/:id/edit" do
    erb :"/resources/edit.html"
  end

  # PATCH: /resources/5
  patch "/resources/:id" do
    redirect "/resources/:id"
  end

  # DELETE: /resources/5/delete
  delete "/resources/:id/delete" do
    redirect "/resources"
  end
end
