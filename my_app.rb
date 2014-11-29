require 'sinatra'
require "yaml"

class MyAppController < Sinatra::Base

  get '/' do
    erb :menu
  end

  get '/menu' do
    erb :menu
  end

  post '/menu' do
    "You said '#{params[:message]}'"
    redirect params[:message].to_sym
  end

  get '/new' do  # => this can be combined with /create
    @projects = file_read
    erb :new
  end

  post '/new' do
    erb :list
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
    write_file(@projects)
    erb :list
  end

  get '/update' do
    @projects = file_read
    erb :update
  end

  post '/update' do
    @projects = file_read
    project_rename(params[:project_name], params[:new_project_name])
    write_file(@projects)
    erb :list
  end

  get '/edit' do
    @projects = file_read
    erb :edit
  end

  post '/edit' do
    @projects = file_read
    erb :'tasks/list'
  end

  get '/tasks/list' do
    @projects = file_read
    erb :'tasks/list'
  end

  post '/tasks/list' do
    erb :'tasks/list'
    # @projects = file_read
    # redirect "tasks/#{params[:task_message]}"
  end

  post '/tasks/create' do
    @projects = file_read
    add_task(params[:project_name], params[:task_name])
    erb :'tasks/list'
  end




  helpers do

    def redirect_hack(params)
      @params = params
    end
    # => Model helpers

    def add_task(project_name, task)
      get_project = @projects.detect { |thing| thing.keys.join  == "#{project_name}" }
      get_project_tasks = get_project[get_project.keys.join]
      get_project_tasks << task
      project_rename(project_name, project_name)
    end

    def project_rename(old_name, new_name)
      get_old_project = @projects.detect { |thing| thing.keys.join  == "#{old_name}" }
      get_old_project_tasks = get_old_project[get_old_project.keys.join].join(", ")

      @projects.each do |project|
        if project == get_old_project
          @projects.delete(project)
          project_add(new_name, get_old_project_tasks)
        end
      end
    end

    def project_add(name, *tasks )
      @projects << { "#{name}" => tasks}
      write_file(@projects)
    end

    def project_delete(name)
        @projects.each.with_index do |listing, index|
          listing.each do |key, value|
            if key == name
               @projects.delete_at(index)
            end 
          end
        end
    end

    def project_present?(name)
      @projects.each.with_index do |listing, index|
          if @projects[index][name.to_sym].exists?
            true
          else
            false
          end
      end
    end


    def file_read
      @projects = []
      if File.exist?('projects.yml')
        data = YAML.load_file('projects.yml')
        if data != false
          return data
        else 
          @projects
        end
      end
    end

    def write_file(projects)
      File.open('projects.yml', 'w') do |f|
        f.write(make_yaml(projects))
      end
    end

    # => YAML HELPERS FOR EASIER USE :)
    def load_yaml(project)
      YAML.load(project)
    end

    def make_yaml(project)
      YAML.dump(project)
    end

    # => View helpers
    def print_projects_list
      @projects.delete_if { |x| x == ""}
    end

    def print_tasks_list(tasks)
      @tasks
    end

    def print_task_menu(project_name)
      task_options = ["Editing Project: #{project_name} ",
        "'list' to list tasks",
        "'create' to create a new task",
        "'edit' to edit a task",
        "'complete' to complete a task and remove it from the list",
      ]
    end

    def print_project_menu
      menu_options = [
        "'menu' to go to main menu",
        "'list' to list projects",
        "'new' to add a new project",
        "'remove' to remove a project",
        "'update' to update a project",
        "'edit' to edit a project",
      ]
    end

    def print_menu_links
      menu_links = [
        "menu",
        "list",
        "new",
        "remove",
        "update",
        "edit",
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
