SamplePokerBot.controllers :player do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  # Return 200 if you're ready to start the game.
  get "/ready" do
    status 200
    "Always!"
  end

  # Return 200 if you accept your seat at the table.
  post "/seat" do
    logger.info "Joining table #{params[:table].inspect}"

    status 200
    "Ready!"
  end
end
