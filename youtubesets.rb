require 'sinatra'
require "sinatra/reloader" if development?

    @@beyonce ||= ["QczgvUDskk0", "VBmMU_iwe6U", "Vjw92oUduEM", "4m1EFMoRFvY", "FHp2KgyQUFk"]
    @@postmodernjukebox ||= ["pXYWDtXbBB0", "VBmCJEehYtU", "GZQJrM09jbU"]


helpers do
  def randomvideo(set)
    set.sample
  end
  def embedyoutube(videonumber)
    '<body style="margin:0;">' + \
    '<object height="100%" width="100%"><param name="movie" value="http://www.youtube.com/v/' + videonumber + '&autoplay=1" /><embed height="100%" src="http://www.youtube.com/v/' + videonumber + '&autoplay=1" type="application/x-shockwave-flash" width="100%"></embed></object>' + \
    '</body>'
  end
end


##Main Welcome Page
get '/' do
  "<h1>Hi!</h1><h2>If you know the url you can play a random video from set of youtube videos!</h2>"
end


##Display the Video Sets
get '/beyonce' do
  #@@beyonce.to_s
  embedyoutube(randomvideo(@@beyonce))
end

get '/postmodernjukebox' do
  embedyoutube(randomvideo(@@postmodernjukebox))
end


##Create a new set (really, just update video list of an old set
get '/newset' do
  %{
    <form name="newyoutubeset" action="createset" method="post">
    Set of videos, one link per line: <textarea name="videoset"></textarea>
    <input type="submit" value="Submit">
    </form>
  }
end

post '/createset' do
  #params["videoset"].to_s
  @@beyonce = params["videoset"].split("\s")
  text = ""
  @@beyonce.each do |videoname|
    text << "I love " + videoname.to_s + "<br>"
  end
  text
end
