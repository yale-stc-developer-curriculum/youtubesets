require 'sinatra'
require "sinatra/reloader" if development?


helpers do
  def randomvideo(set)
    set.sample
  end
  def gathervideos()
    @beyonce = ["QczgvUDskk0", "VBmMU_iwe6U", "Vjw92oUduEM", "4m1EFMoRFvY", "FHp2KgyQUFk"]
    @postmodernjukebox = ["pXYWDtXbBB0", "VBmCJEehYtU", "GZQJrM09jbU"]
  end
  def embedyoutube(videonumber)
    '<body style="margin:0;">' + \
    '<object height="100%" width="100%"><param name="movie" value="http://www.youtube.com/v/' + videonumber + '&autoplay=1" /><embed height="100%" src="http://www.youtube.com/v/' + videonumber + '&autoplay=1" type="application/x-shockwave-flash" width="100%"></embed></object>' + \
    '</body>'
  end
end

get '/' do
  "<h1>Hi!</h1><h2>If you know the url you can play a random video from set of youtube videos!</h2>"
end

get '/beyonce' do
  gathervideos()
  embedyoutube(randomvideo(@beyonce))
end

get '/postmodernjukebox' do
  gathervideos()
  embedyoutube(randomvideo(@postmodernjukebox))
end
