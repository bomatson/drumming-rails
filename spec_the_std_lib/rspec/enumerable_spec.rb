describe Enumerable do
  describe 'public #instance methods' do
    context 'given a collection' do
      let(:collection) { ['ant', 'true', 'fragrance', 'banana'] }

      context 'where an iteration expects a boolean return value' do

        it 'all? returns true if the block never returns false or nil' do
          expect(
            collection.all? { |word| word.length < 10 }
          ).to eq true
        end

        it 'all? returns false if the block ever returns false or nil' do
          expect(
            collection.all? { |word| word.length < 9 }
          ).to eq false
        end

        it 'all? without a block will implicitly return true if no collection items are nil or false' do
          expect(collection.all?).to be_true
        end

        it 'any? returns true if the block ever returns a value other than false or nil' do
          expect(
            collection.any? { |word| word.length < 10 }
          ).to eq true

          expect(
            collection.any? { |word| word.length == 3 }
          ).to eq true
        end
      end

      context 'where an iteration expects to return an enumerator' do
        let(:numbers) { [1,2,3,4,5,6] }

        it 'chunk will return enumeration if given a block' do
          expect(
            collection.chunk{ |string | string.include?('s') }
          ).to be_kind_of Enumerator
        end

        it 'with chunk, consecutive elements which return the same block value are grouped together' do
          expect(
            collection.chunk{ |string | string.include?('t') }
         .select { |result| result }
          ).to eq([[true, ['ant', 'true']], [false, ['fragrance', 'banana']]])
        end
      end
    end
  end
end
