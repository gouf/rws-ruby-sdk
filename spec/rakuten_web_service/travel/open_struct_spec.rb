require 'spec_helper'
require 'rakuten_web_service/travel'

describe RakutenWebService::Travel::OpenStruct do
  let(:object) { RakutenWebService::Travel::OpenStruct.new(params) }

  context 'Given simple hash with pairs of key-value' do
    let(:params) do
      { foo: 'bar', 'hoge' => 1, 'min-size' => 10, 'maxSize' => 100 }
    end

    specify 'should have interfaces with the name of a given hash keys' do
      expect(object).to respond_to(:foo)
      expect(object.foo).to eq(params[:foo])
      expect(object).to respond_to(:hoge)
      expect(object.hoge).to eq(params['hoge'])
    end
    specify 'should generate snakecase-method name' do
      expect(object).to respond_to('min-size')
      expect(object).to respond_to('min_size')
      expect(object).to respond_to('maxSize')
      expect(object).to respond_to('max_size')
    end
  end

  context 'Given a hash including a hash' do
    let(:params) do
      {
        name: 'Taro',
        address: { country: :jp, city: :tokyo }
      }
    end

    specify 'the inside hash should be converted to OpenStruct' do
      expect(object.address).to respond_to(:country)
      expect(object.address).to respond_to(:city)
    end
  end
end