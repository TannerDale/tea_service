require 'rails_helper'

describe V2::TeaFacade, :vcr do
  it 'fetch teas and turns them to poros' do
    result = V2::TeaFacade.fetch_teas

    expect(result).to be_an Array
    expect(result).to_not be_empty
    expect(result.first).to be_a TeaPoro
  end
end
