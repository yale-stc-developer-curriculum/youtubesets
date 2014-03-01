require "sinatra"
require "sinatra/reloader" if development?


configure do
  enable :sessions
end


helpers do
  def randomvideo(set)
    set.sample
  end
  def embedyoutube(videourl)
    '<body style="margin:0;">' + \
    '<object height="100%" width="100%"><param name="movie" value="' + videourl + '&autoplay=1" /><embed height="100%" src="' + videourl + '&autoplay=1" type="application/x-shockwave-flash" width="100%"></embed></object>' + \
    '</body>'
  end
  def beyoncevideos
    ["QczgvUDskk0", "VBmMU_iwe6U", "Vjw92oUduEM", "4m1EFMoRFvY", "FHp2KgyQUFk"]
  end
  def pmjvideos
    ["www.youtube.com/watch?v=pXYWDtXbBB0", "www.youtube.com/watch?v=VBmCJEehYtU", "www.youtube.com/watch?v=GZQJrM09jbU"]
  end
end

##INDEX
##Main Welcome Page
get '/' do
  "<h1>Hi!</h1><h2>If you know the url you can play a random video from set of youtube videos!</h2>" + \
    "<a href='set/new'>New Set</a>"

end

##Display the Video Sets
get '/beyonce' do
  #@@beyonce.to_s
  embedyoutube(randomvideo(beyoncevideos))
end

get '/pmj' do
  embedyoutube(randomvideo(pmjvideos))
end


#Session for troubleshooting
get '/session' do
  session.inspect
end

get '/params/:idlol' do
  params.inspect
end


