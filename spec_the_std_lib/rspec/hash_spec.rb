require "rubygems"
require "rspec"

describe Hash do
	let(:hash) {{a: 1234, b: 'string'}}

  it 'is an instance of Hash' do
    expect(hash).to be_instance_of Hash
  end

  it 'is a kind of Hash' do
    expect(hash).to be_kind_of Hash
  end

 context 'can be created' do
    it 'using literal Hash syntax' do
      expect(Hash['a', 100, 'b', 200]).to eq({'a' => 100, 'b' => 200})
    end

    it 'using an implicit form' do
      expect({ Robert: 26,  Nicolle: 26 }).to eq({:Robert=>26, :Nicolle=>26})
    end

    it 'uses the new method' do
      expect(Hash.new).to be_kind_of Hash
    end

    it 'with a default value of nil' do
      expect(hash.default).to eq nil
    end

    it 'sets the default value with new method' do
      expect(Hash.new("rabbit").default).to eq "rabbit"
    end

    it 'sets the default using the default method' do
      hash.default = 0
      expect(hash.default).to eq 0
    end
  end

 context 'accesses its values' do
   it 'using a symbol reference if the key is a symbol' do
     expect(hash[:a]).to eq 1234
   end

   it 'without using a string reference if the key is a symbol' do
     expect(hash['a']).to_not eq 1234
   end

   it 'using the values method' do
     expect(hash.values).to eq [1234, 'string']
   end

   it 'with the ability to override the value' do
     hash[:a] = 123
     expect(hash[:a]).to eq 123
   end
 end
end
