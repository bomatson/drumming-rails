require "rubygems"
require "rspec"

describe Hash do
	let(:hash) {{a: "a", b: "b"}}

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
      expect({ Robert: 25,  Nicolle: 26 }).to eq({:Robert=>25, :Nicolle=>26})
    end

    it 'uses the new method' do
      expect(Hash.new).to be_kind_of Hash
    end
  end
end
