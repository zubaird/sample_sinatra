require 'sinatra'

class MyAppController < Sinatra::Base

  get '/' do
    'Hello World!'
  end

  get '/menu' do
    erb :menu
  end

  post '/menu' do
    "You said '#{params[:message]}'"
    redirect params[:message].to_sym
  end

  get '/new' do
    erb :new
  end

  post '/new' do
    erb :create
  end

  get '/create' do
    @projects = file_read
    erb :create
  end

  post '/create' do
    @projects = file_read
    project_add(params[:project_name])
    erb :list
  end

  get '/list' do
    @projects = file_read
    erb :list
  end

  get '/remove' do
    @projects = file_read
    erb :remove
  end

  post '/remove' do
    @projects = file_read
    project_delete(params[:project_name])
    erb :list
  end

  helpers do
    # => Model helpers
    def project_add(name)
      @projects << name
      write_file
    end

    def project_delete(name)
      if project_present?(name)
        @projects.delete(name)
      else
        "could not delete #{name}"
      end
    end

    def project_present?(name)
      @projects.include?(name)
    end

    def file_read
      File.exist?('projects.txt') ? (File.open('projects.txt', 'r').read.split("\n")) : Array.new
    end

    def write_file
      data_string = @projects.join("\n")
      File.open('projects.txt', 'w') do |f|
        f.write(data_string)
      end
    end

    # => View helpers
    def print_projects_list
      @projects
    end

    def print_project_menu
      menu_options = [
        "'list' to list projects",
        "'new' to add a new project",
        "'remove' to remove a project",
        "'update' to update a project",
      ]
    end

    def print_project_create_prompt
      "Please enter the new project name:\n"
    end

    # V, printer
    def print_project_delete_prompt
      "Please enter the project name to delete:\n"
    end

    def print_project_rename_prompt
      "Please enter the project name to rename:\n"
    end

    def print_prompt_for_new_project_name
      "Please enter the new project name:\n"
    end

    def print_project_edit_prompt
      "Which project would you like to edit?\n"
    end

    def print_task_edit_prompt
      "Please enter the task you would like to edit."
    end

    def print_prompt_for_new_task_name
      "Please enter the new task name:\n"
    end

    def print_new_task_prompt
      "Please enter the task you would like to add."
    end

    def print_task_not_here_message(name)
      "task not found: '#{name}'"
    end

  end

end
