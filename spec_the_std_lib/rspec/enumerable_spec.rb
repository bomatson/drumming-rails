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

        it 'include? returns true if any elem in enum equals obj' do
          expect(collection.include?('fragrance')).to be_true
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

        it 'each_cons iterates over the block for each array of consecutive n elements' do
          consecutive = []
          collection.each_cons(3) do |words|
            consecutive << words
          end
          expect(consecutive).to eq([['ant', 'truth', 'fragrance'], ['truth', 'fragrance', 'banana']])
        end

        it 'each_slice iterates over the block for each slice of n elements' do
          slices = []
          numbers.each_slice(2) do |nums|
            slices << nums
          end
          expect(slices).to eq([[1,2,],[3,4],[5]])
        end

        it 'each_with_index to access the each elements index' do
          indexes = []
          collection.each_with_index{ |str, idx| indexes << idx }
          expect(indexes).to eq([0,1,2,3])
        end

        it 'entries returns an array of items in enum' do
          expect(
            {a: 'new', b: 'old'}.entries
          ).to eq [[:a, 'new'], [:b, 'old']]
        end

        it 'find_all recovers all the elem for which a block is true as an array' do
          expect(
            numbers.find_all{ |num| num % 2 == 0 }
          ).to eq [2,4]
        end

        it 'grep grabs every elem in enum where the pattern exactly matches' do
          expect(numbers.grep(1..3)).to eq([1,2,3])
        end

        it 'grep grabs every elem in enum where the pattern exactly matches with regex' do
          expect(collection.grep(/h$/)).to eq(['truth'])
        end

        it 'grep with a block passes each matching elem to the block and storing each result in arr' do
          expect(
            numbers.grep(1..3) { |n| n >= 2 }
          ).to eq([false, true, true])
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

        it 'uses find_index to compare entry in enum with given value, returning the index' do
          expect(collection.find_index('fragrance')).to eq 2
        end

        it 'uses find_index with block to return index for FIRST enum entry which evals to true' do
          expect(
            collection.find_index { |str| str.include?('r') }
          ).to eq 1
        end
      end

      context 'where an iteration expects to return nil' do

        it 'cycle calls block for each element in enum n times' do
          # I could see this being useful if you need to iterate over each element more than once
          # BUT MAKE SURE to pass in an arg, or it will go on forever (literally)

          expect(
            collection.cycle(2){ |x| x }
          ).to be_nil
        end
      end

      context 'where an iteration expects to return a hash' do
        it 'group_by groups collection by the result of the block' do
          #keys are the evaluated result and the values are an array of elem that correspond to the result
          expect(
            numbers.group_by{|num| num % 2 }
          ).to eq({1=>[1, 3, 5], 0=>[2, 4]})
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

        it 'find behaves the exact same way as detect' do
          expect(
            collection.find{ |str| str.include?('r') }
          ).to eq 'truth'
        end

        it 'each_with_object iterates with an arbitrary obj given, returns initally given object' do
          something = collection.each_with_object([]) do |elem, obj|
            obj << (elem + "poo")
          end
          expect(something).to eq ["antpoo", "truthpoo", "fragrancepoo", "bananapoo"]
        end

        it 'uses first to return the first element' do
          expect(collection.first).to eq 'ant'
        end

        it 'uses first with an arg to return initial n elements' do
          expect(collection.first(2)).to eq ['ant', 'truth']
        end

        context 'with inject / reduce' do
          it 'performs a binary operation on each elem from given block' do
            expect(
              numbers.inject {|sum, n| sum + n }
            ).to eq 15
          end

          it 'if a symbol is specified, each elem is passed to given method' do
            expect(numbers.reduce(:-)).to eq -13
          end

          it 'will perform with an initial value' do
            expect(
              numbers.reduce(3, :+)
            ).to eq 18
          end
        end
      end
    end
  end
end
