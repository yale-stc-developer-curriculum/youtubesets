require "sinatra"
#To get this next line to work, run gem install sinatra-contrib first
require "sinatra/reloader" if development?
require "uri"
require "cgi"


configure do
  enable :sessions
  #HTML can pass only get/post methods. This enables us to get delete (see my post on piaza)
  _method = true
end


helpers do
  def randomvideo(set)
    set.sample
  end

  #We're trying not to use the rest of these helpers any more, but they're here to make the pmj code below still work for comparison
  def embedyoutube(videonumber)
    %{
    <body style="margin:0;">
    <object height="100%" width="100%"><param name="movie" value="http://www.youtube.com/v/#{videonumber}&autoplay=1" /><embed height="100%" src="http://www.youtube.com/v/#{videonumber}&autoplay=1" type="application/x-shockwave-flash" width="100%"></embed></object>
    </body>
    }
  end
end

##INDEX
##Main Welcome Page
get '/' do
  erb :index 
end

##New, RESTful code

##just view parameters (should be blank) for debugging purposes
get '/params' do
  erb :index_with_params
end

#Session for troubleshooting
get '/session' do
  erb :index_with_session
end

##NEW page
get '/sets/new' do
  erb :new
end

#This is what really happens after submitting the form
#also: old habbits die hard: for now, I will define the variables before I initialize them!
post "/sets/new" do
  params.inspect
  arr = params[:Set]
  
  links = []
  key=[]

  #if there are more than one element in the links box, split them and append to links
   if !params[:linkz].match(/\r\n/).nil?
    links = params[:linkz].split("\r\n")
    key = links
   else 
  #otherwise just add this one element to links
    links = [params[:linkz]]
    key = links
   end
    #parsing the links. I don't really know what exactly is happening, but I know why it is happening ;P
    key = key.map{|x| if x.to_s =~ URI::regexp
        CGI.parse(URI.parse(x.to_s).query)['v']
      end}
      
      key = key.map{|x| x[0] if !x.nil?}
      
    session['list_' + arr] = key
    session[arr] = links
    #if in the process we do not get any meaningful links -> there are no "?v" paramaters, enable display error in index and delete the keys from session
      if session['list_' + arr].nil?
        @error = 1
        session.delete('list_'+arr)
        session.delete(arr)
      end
  erb :index
end


##not the RESTful new page with the form we want, but a parameters way to make a new video set
get '/sets/new/:setname/:videonumber' do |setname, videonumber|
  #setname = "pharrell"
  #videonumber = "y6Sxv-sUYtM"
  session[setname] = [videonumber]
  "Video " + videonumber + "is now the only video in setname " + setname
end

get '/sets/add/:setname/:videonumber' do |setname, videonumber|
  session[setname] << videonumber
  "Video " + videonumber + "has been added to set " + setname
end


##Play the Pharrell video set - not necessary eventually, just for testing
get '/sets/pharrell' do
  @videonumber = randomvideo(session["pharrell"])
  #@videonumber = "y6Sxv-sUYtM"
  erb :play
end



#Session page for troubleshooting the session
get '/session' do
  session[:sessiontestvariable] = 3.14
  session.inspect
end


##example of sinatra input by url parameters
##The ?var=1&var2=2&var3=3 style works too, but Sinatra can give us prettier url parameters
get '/params/:idlol' do
  params.inspect
end

get '/favorite/:fruit' do |fruit|
  "My favorite fruit is the " + fruit.to_s
  #params["fruit"] also works instead of fruit
end

get '/add/:num1/:num2' do |num1, num2|
  ##your code here, as an example
end
