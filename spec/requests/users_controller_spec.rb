require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET users#index' do
    before { get users_path }

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
    it 'returns ok status code (200)' do
      expect(response).to have_http_status(200)
    end
    it 'renders with tittle List of users' do
      expect(response.body).to include('List of Users')
    end
  end

  describe 'GET users#id' do
    before { get user_path(1) }

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
    it 'returns ok status code (200)' do
      expect(response).to have_http_status(200)
    end
    it 'renders with tittle User with ID: XXXXXX' do
      expect(response.body).to include('User with ID: XXXXXX')
    end
  end
end
