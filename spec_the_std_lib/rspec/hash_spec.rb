require "rubygems"
require "rspec"

describe 'Hash' do
	let(:hash) {{a: "a", b: "b"}}

  it 'example is an instance of Hash' do
    expect(hash).to be_instance_of(Hash)
  end

  it 'example is a kind of Hash' do
    expect(hash).to be_kind_of(Hash)
  end

  it 'will use literal Hash syntax to create a new hash' do
    expect(Hash['a', 100, 'b', 200]).to eq({'a' => 100, 'b' => 200})
  end
end
