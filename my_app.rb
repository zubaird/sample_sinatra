$:.unshift File.expand_path('../lib', __FILE__)

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym


require 'sinatra'
require "yaml"
require "AppHelpers"
require "project"


class MyAppController < Sinatra::Base

  helpers AppHelpers

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

  get '/tasks' do
    erb :menu
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
    write_file(@projects)
    erb :list
  end


end
