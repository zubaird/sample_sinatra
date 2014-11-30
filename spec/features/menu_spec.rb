require_relative '../spec_helper'

describe 'Menu' do
  describe 'GET /menu' do
    before { get '/menu' }

    it 'is successful' do
      expect(last_response.status).to eq 200
    end
  end
  describe 'POST /menu when list is selected' do
    before { post '/menu', {message: 'list'}}
    it "redirects to /list" do
      follow_redirect!
      expect(last_request.path).to eq '/list'
    end
  end
  describe 'POST /menu when new is selected' do
    before { post '/menu', { message: 'new'}}
    it "redirects to /new" do
      follow_redirect!
      expect(last_request.path).to eq '/new'
    end
  end
  describe 'POST /menu when remove is selected' do
    before { post '/menu', {message: 'remove'}}
    it "redirects to /remove" do
      follow_redirect!
      expect(last_request.path).to eq '/remove'
    end
  end
  describe 'POST /menu when update is selected' do
    before { post '/menu', {message: 'update'}}
    it "redirects to /update" do
      follow_redirect!
      expect(last_request.path).to eq '/update'
    end
  end
  describe 'POST /menu when edit is selected' do
    before { post '/menu', {message: 'edit'}}
    it "redirects to /edit" do
      follow_redirect!
      expect(last_request.path).to eq '/edit'
    end
  end
  describe 'POST /menu when menu is selected' do
    before { post '/menu', {message: 'menu'}}
    it "redirects to /menu" do
      follow_redirect!
      expect(last_request.path).to eq '/menu'
    end
  end
end
