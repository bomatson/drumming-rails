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

    context 'given a default value' do
      before do
        hash.default = 'cats'
      end

      it 'accesses the default using the default method' do
        expect(hash.default).to eq 'cats'
      end

      it 'will reference the default if the key is not found' do
        expect(hash['goober']).to eq 'cats'
      end

      it 'will use a proc to change the default value' do
        hash.default_proc = proc do |hash, key|
          hash[key] = 'you should not have said ' + key
        end
        expect(hash['goober']).to eq 'you should not have said goober'
      end
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

    it 'with the ability to set a new key and value' do
     hash[:c] = 'awesome'
     expect(hash[:c]).to eq 'awesome'
    end
  end

  context 'uses equality to compare hashes' do
    let(:identical) {{a: 1234, b: 'string'}}

    it 'with the == operator' do
     expect(identical == hash).to be true
    end
  end

  context 'manipulates its objects' do
    let(:mani) {{'a' => 100, b: 'unchanged'}}

    it 'with clear to empty the hash' do
      expect(hash.clear).to be_empty
    end

    it 'with delete to remove an element by its key' do
      hash.delete(:a)
      expect(hash).to_not include 1234
    end

    it 'with delete to return nil if key is not present' do
      expect(hash.delete(:z)).to be_nil
    end

    it 'with compare_by_identity to reference objects in hash using object_ids' do
      # note that symbols have the same object_id, so they are unaffected
      # the hash evaluates reference using equal? instead of eql?
      mani.compare_by_identity
      expect(mani['a']).to be_nil
    end
  end
end
