describe Proc do
  describe 'public class methods' do
    def test_proc
      Proc.new
    end

    it '.new with a block creates a new Proc object' do
      expect(Proc.new { 'hi' }).to be_kind_of Proc
    end

    it '.new without a block only in method with attached block' do
      expect(
        test_proc { 'hi' }
      ).to be_kind_of Proc
    end
  end

  describe 'public instance methods' do
    let(:my_proc) { Proc.new { |x| x < 3 } }
    let(:proc_with_opts) { proc { |a, *b| b.collect { |i| i * a } } }
    let(:lambda_proc)    { lambda {|x| x < 3 } }
    let(:proc_with_many_args) { proc { |a, b, c| (a||0) + (b||0) + (c||0) } }

    it '=== invokes the block with object as proc\'s parameter like call' do
      expect( my_proc === 4 ).to be_false
    end

    it '[] invokes the block with params' do
      expect( my_proc[1,2] ).to be_true
    end

    it '#arity returns number of args that would be used in a proc with finite args' do
      expect(my_proc.arity).to eq 1
    end

    it '#arity returns mandatory args as -n - 1 if optional args in the block' do
      expect(
        proc{ |*a| }.arity
      ).to eq -1
    end

    it '#binding returns the execution context retained for future use'  do
      expect(
        my_proc.binding
      ).to be_kind_of Binding
    end

    it '#call invokes the block, setting the block args to the values in params' do
      expect(my_proc.call(6)).to be_false
    end

    it '#call is synonymous with using .()' do
      expect(my_proc.(2)).to be_true
    end

    it '#call invokes the block with optional args' do
      expect(
        proc_with_opts.call(5, 1, 2, 3)
      ).to eq [5, 10, 15]
    end

    it '#call raises an error for proc created with lambda if multiple values passed in for one' do
      expect{ lambda_proc.call(1,2) }.to raise_error
    end

    it '#curry callng a proc with too few args will return another proc' do
      expect(proc_with_many_args.curry[2, 3]).to be_kind_of Proc
    end

    it '#curry callng a proc with sufficient args will return the result' do
      expect(proc_with_many_args.curry[2, 3, 4]).to eq 9
    end

    it '#curry will carry the state of the proc' do
      curried = proc_with_many_args.curry[2, 3]
      expect(curried.curry[4]).to eq 9
    end

    it '#hash returns a hash value integer corresponding to proc body' do
      expect(my_proc.hash).to be_kind_of Integer
    end

    it '#inspect and #to_s return the line number of proc definition' do
      expect(my_proc.inspect).to include 'proc_spec.rb:19'
    end

    context 'error handling compared to lambdas' do
      let(:lambda_with_many_args) { lambda {|x,y, z| (x||0) + (y||0) + (z||0)} }

      it '#lambda? returns true for a Proc object for which arg handling is rigid' do
        expect(lambda_proc.lambda?).to be_true
      end

      it 'proc will ignore extra elements during a call' do
        expect(proc_with_many_args[2,3,4,5,6]).to eq 9
      end

      it 'lambda will raise an error with extra elements during a call' do
        expect{ lambda_with_many_args[2,3,4,5,6] }.to raise_error(ArgumentError)
      end

      it 'proc will pass in nil if not enough args are supplied' do
        expect( proc_with_many_args[1, 2] ).to eq 3
      end

      it 'lambda raises an error if there are too few args' do
        expect{ lambda_with_many_args[1,2] }.to raise_error(ArgumentError)
      end

      it 'proc expands a single array argument' do
        expect( proc_with_many_args[ [1, 2] ] ).to eq 3
      end

      it 'lambda raises an error if trying to expand an array with too few args' do
        expect{ lambda_with_many_args[ [1,2] ] }.to raise_error(ArgumentError)
      end
    end
  end
end
