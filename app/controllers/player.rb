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
  # This is a good time to update or clear your game state.
  post "/seat" do
    logger.info "Joining table #{params[:table].inspect}"

    status 200
    "Ready!"
  end

  # Get your bot's action for the next turn.
  # Data passed in:
  # {
  #   :min_bet => 20,
  #   :your_chips => 100
  # }
  #
  # Return 200 and your action in the format:
  # {
  #   :action => "bet",
  #   :amount => 25
  # }
  # A 400-level error or no response will indicate a fold.
  post "/action" do
    logger.info "Deciding action for #{params.inspect}"

    content_type :json

    if params[:your_chips] > params[:min_bet]
      status 200
      { :action => "bet", :amount => params[:min_bet] }.to_json
    else
      status 403
      { :action => "fold"}.to_json
    end
  end
end
