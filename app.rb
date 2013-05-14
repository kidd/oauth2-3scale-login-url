#shotgun app.rb -p 9294
require 'sinatra'

nginx_redirect_uri =  "http://api.2445579853692.proxy.3scale.net:80/callback?"  #nginx callback


get("/login") do
  @my_local_state = params[:state]
  @plan_id = params[:scope]
  @pre_token = params[:tok]
  erb :login
end

post("/set-redirect-uri") do
  if params[:redirect_uri]
    nginx_redirect_uri = params[:redirect_uri]
  else
    status 500
  end
end

get("/red") do
  body "<html><body>" + nginx_redirect_uri + "</body></html>"
end


post("/log") do
  red =  "#{nginx_redirect_uri}&state=#{params[:state]}"
  puts red
  redirect red
end

# Why I can't ping this enpoint bypassing the nginx port?
get("/read") do
  erb :secure
end

# Why I can't ping this enpoint bypassing the nginx port?
get("/write") do
  erb :write
end
