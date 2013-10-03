describe Enumerable do
  describe 'public #instance methods' do
    context 'given a collection' do
      let(:collection) { ['ant', 'truth', 'fragrance', 'banana'] }
      let(:numbers)    { [ 1, 2, 3, 4, 5 ] }

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

        it 'chunk will return enumeration if given a block' do
          expect(
            collection.chunk{ |string | string.include?('s') }
          ).to be_kind_of Enumerator
        end

        it 'with chunk, consecutive elements which return the same block value are grouped together' do
          expect(
            collection.chunk{ |string | string.include?('t') }
         .select { |result| result }
          ).to eq([[true, ['ant', 'truth']], [false, ['fragrance', 'banana']]])
        end

        it 'with chunk using :_alone symbol to force items into their own grouping' do
          expect(
            collection.chunk{ |string | string.include?('t') ? :_alone : false }
         .select { |result| result }
          ).to eq( [[:_alone, ['ant']], [:_alone, ['truth']], [false, ['fragrance', 'banana']]])
        end
      end

      context 'where an iteration expects to return an array' do

        it 'collect with a block modifies each item in the collection' do
          expect(
            collection.collect{ |word| word.to_sym }
          ).to eq([:ant, :truth, :fragrance, :banana])
        end

        it 'collect passed a range will only affect those items' do
          expect(
            collection[0..1].collect{ |word| word.to_sym }
          ).to eq([:ant, :truth])
        end

        it 'collect returns a new array' do
          new = collection.collect{ |word| word.to_sym }
          expect(new).to_not eq collection
        end

        it 'drop moves first n elements in enum to return same array' do
          expect(collection.drop(1)).to eq(['truth', 'fragrance', 'banana'])
        end

        it 'drop_while remove n items up to the first element for which the block evals to false' do
          expect(
            numbers.drop_while{ |i| i < 3 }
          ).to eq [ 3, 4, 5 ]
        end

        it 'each_cons iteates over the block for each array of consecutive n elements' do
          consecutive = []
          collection.each_cons(3) do |words|
            consecutive << words
          end
          expect(consecutive).to eq([['ant', 'truth', 'fragrance'], ['truth', 'fragrance', 'banana']])
        end

        context 'given an array of arrays' do
          let(:new_array) { [[1,2,],[3,4]] }

          it 'uses collect_concat / flat_map to return concatenated results of running block once for each item' do
            expect(
              new_array.flat_map { |number| number << 'new' }
            ).to eq([1,2,'new',3,4,'new'])
          end
        end
      end

      context 'where an iteration expects to return an integer' do

        it 'uses count to return number of items in enum through enumeration' do
          expect(collection.count).to eq 4
        end

        it 'uses count with an arg to return number of items in enum equal to arg' do
          expect(collection.count('ant')).to eq 1
        end

        it 'uses count with a block to count number of item yielding true value' do
          expect(
            collection.count{ |x| x.include?('t') }).to eq 2
        end
      end

      context 'where an iteration expects to return an integer' do

        it 'cycle calls block for each element in enum n times' do
          # I could see this being useful if you need to iterate over each element more than once
          # BUT MAKE SURE to pass in an arg, or it will go on forever (literally)

          expect(
            collection.cycle(2){ |x| x }
          ).to be_nil
        end
      end

      context 'where an iteration expects any object return value' do

        it 'detect returns the first obj for which block is true' do
          expect(
            collection.detect{ |str| str.include?('r') }
          ).to eq 'truth'
        end

        it 'detect returns nil if no obj is evaluated to true' do
          expect(
            collection.detect{ |str| str.include?('z') }
          ).to be_nil
        end

        it 'detect returns ifnone call value if no obj is evaluated to true' do
          expect(
            collection.detect(ifnone = proc {:foo}){ |str| str.include?('z') }
          ).to eq :foo
        end
      end
    end
  end
end
