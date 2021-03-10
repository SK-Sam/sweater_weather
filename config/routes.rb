Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get '/forecast', to: 'forecast#city_weather'
      get '/backgrounds', to: 'background#city_image'
      post '/users', to: 'users#create'
    end
  end
end
