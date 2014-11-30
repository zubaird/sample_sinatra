require_relative '../spec_helper'

describe 'Root Path' do
  describe 'GET /' do
    before { get '/' }

    it 'is successful' do
      expect(last_response.status).to eq 200
    end
  end
end

describe 'New' do
  describe 'GET /new' do
    before { get '/new' }

    it 'is successful' do
      expect(last_response.status).to eq 200
    end
  end
end

describe "Create Action" do
  before do
    post "/create", {project_name: "Sample Project"}
  end

  it "creates a project and redirects to list" do
    expect(last_response.body).to include("Sample Project")
  end
end

describe 'list' do
  describe 'GET /list' do
    before { get '/list' }

    it 'is successful' do
      expect(last_response.status).to eq 200
    end
  end
end

describe 'Update' do
  describe 'GET /update' do
    before { get '/update' }

    it 'is successful' do
      expect(last_response.status).to eq 200
    end
  end
end

describe 'Edit' do
  describe 'GET /edit' do
    before { get '/edit' }

    it 'is successful' do
      expect(last_response.status).to eq 200
    end
  end
end

describe 'Tasks/list' do
  describe 'GET /tasks' do
    before { get '/tasks' }

    it 'is successful' do
      expect(last_response.status).to eq 200
    end
  end
end
