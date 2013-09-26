describe Enumerable do
  describe 'public #instance methods' do
    context 'given a collection' do
      let(:collection) { ['ant', 'fragrance', 'banana'] }

      it 'all? returns true if the block never returns false or nil' do
        expect(
          collection.all? { |word| word.length < 10 }
        ).to eq true
      end

      it 'all? without a block will implicitly return true if no collection items are nil or false' do
        expect(collection.all?).to be_true
      end
    end
  end
end
