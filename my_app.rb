require 'sinatra'

class MyApp < Sinatra::Base
  get '/' do
    'Hello World!'
  end

  get '/more/*' do
    params[:splat]
  end

  get '/menu' do
    erb :menu
  end

  post '/menu' do
    "You said '#{params[:message]}'"
    erb params[:message].to_sym
  end


  helpers do
    def print_project_menu
      menu_options = [
        "'list' to list projects",
        "'create' to create a new project",
        "'edit' to edit a project",
        "'delete' to rename a project",
      ]
    end


  end

end
