require 'rails_helper'

describe TeaPoro do
  let(:data) do
    {
      _id: 'asdfas2323',
      name: 'Hello',
      description: 'World',
      brew_time: '1242',
      temperature: '112'
    }
  end
  let!(:tea_poro) { TeaPoro.new(data) }

  it 'has attributes' do
    expect(tea_poro.id).to eq data[:_id]
    expect(tea_poro.title).to eq data[:name]
    expect(tea_poro.description).to eq data[:description]
    expect(tea_poro.brew_time).to eq data[:brew_time].to_i
    expect(tea_poro.temperature).to eq data[:temperature].to_i
  end
end
