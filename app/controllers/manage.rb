SamplePokerBot.controllers :manage do
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

  get "/" do
    render 'manage/index'
  end

  post "/register" do
    begin
      RestClient.post params[:server], { :hostname => params[:hostname], :name => params[:name]}
      flash[:notice] = "Successfully registered."
    rescue => e
      flash[:notice] = "Did not register!"
    ensure
      redirect "/manage"
    end
  end
end
