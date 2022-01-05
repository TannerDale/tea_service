require 'rails_helper'

describe TeaClient, :vcr do
  let(:expected_keys) do
    %i[_id name image description keywords origin brew_time temperature comments __v]
  end

  it 'returns an array of teas' do
    result = TeaClient.fetch('/tea')

    expect(result).to be_an Array
    expect(result.first).to be_a Hash
    expect(result.first.keys).to eq(expected_keys)
  end
end
