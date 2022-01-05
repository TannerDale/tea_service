require 'rails_helper'

describe TeaFacade, :vcr do
  it 'fetch teas and turns them to poros' do
    result = TeaFacade.fetch_teas

    expect(result).to be_an Array
    expect(result).to_not be_empty
    expect(result.first).to be_a TeaPoro
  end
end
