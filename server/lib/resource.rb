class MHDApp
  get "/" do
    redirect "/resource.html"
  end

  get '/resource.html' do
    erb :'resource'
  end
  
  get '/resource' do
    content_type :json

    response = { :hello => "world" }

    response.to_json
  end
end
