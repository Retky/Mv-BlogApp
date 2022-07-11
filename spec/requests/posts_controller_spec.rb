require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET users#user_id#posts' do
    before { get user_posts_path(1) }

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
    it 'returns ok status code (200)' do
      expect(response).to have_http_status(200)
    end
    it 'renders with tittle List of Post from User' do
      expect(response.body).to include('List of Post from User')
    end
  end

  describe 'GET users#user_id#posts#id' do
    before { get user_post_path(1, 1) }

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
    it 'returns ok status code (200)' do
      expect(response).to have_http_status(200)
    end
    it 'renders with tittle Post XX' do
      expect(response.body).to include('Post XX')
    end
  end
end
