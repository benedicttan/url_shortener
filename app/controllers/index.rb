require 'uri'

get '/error/:error' do
  # let user create new short URL, display a list of shortened URLs
  @urls = Url.all
  case params[:error]
  when "url"
    @error = "Looks like an invalid URL!"
  end

  erb :index
end

get '/' do
  # let user create new short URL, display a list of shortened URLs
  @urls = Url.all
  erb :index
end

post '/urls' do
  # create a new Url
  if params[:long_url] =~ URI::regexp(['http', 'https'])
    Url.create(long_url: params[:long_url])
    redirect to('/')
  else
    redirect to('/error/url')
  end
end

# e.g., /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  that_url = Url.where(short_url: "http://localhost:9393/" << params[:short_url]).first
  if !(that_url.click_count)
    #because some entries were initiated before the click_count col was created, they had nil count which I could not += 1 to
    that_url.click_count = 1
  else
    that_url.click_count += 1
  end
  that_url.save
  redirect to(that_url.long_url)
end