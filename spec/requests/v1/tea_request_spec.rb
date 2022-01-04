require 'rails_helper'

describe 'Teas Request' do
  describe 'GET v1/teas' do
    let!(:teas) { create_list :tea, 5 }
    let(:json) { JSON.parse(response.body, symbolize_names: true) }
    let(:first_tea) { json[:teas].first }

    before { get api_v1_teas_path }

    it 'returns all of the teas with their information' do
      expect(json[:teas].count).to eq 5
      expect(json[:teas].first.keys).to eq(%i[id title temperature description brew_time])

      expect(first_tea[:id]).to eq(teas.first.id)
      expect(first_tea[:title]).to eq(teas.first.title)
      expect(first_tea[:description]).to eq(teas.first.description)
      expect(first_tea[:temperature]).to eq(teas.first.temperature)
      expect(first_tea[:brew_time]).to eq(teas.first.brew_time)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status 200
    end
  end
end
