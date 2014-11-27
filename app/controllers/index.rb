get '/' do
  # let user create new short URL, display a list of shortened URLs
  @urls = Url.all
  erb :index
end

post '/urls' do
  # create a new Url
  Url.create(long_url: params[:long_url])
  redirect to('/')
end

# e.g., /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  redirect to(Url.where(short_url: "http://localhost:9393/" << params[:short_url]).first.long_url)
end