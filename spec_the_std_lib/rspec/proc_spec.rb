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

    it '=== invokes the block with object as proc\'s parameter like call' do
      expect( my_proc === 4 ).to be_false
    end

    it '[] invokes the block with params' do
      expect( my_proc[1,2] ).to be_true
    end

    it 'arity returns number of args that would be used in a proc with finite args' do
      expect(my_proc.arity).to eq 1
    end

    it 'arity returns mandatory args as -n - 1 if optional args in the block' do
      expect(
        proc{ |*a| }.arity
      ).to eq -1
    end

    it 'binding returns the execution context retained for future use'  do
      expect(
        my_proc.binding
      ).to be_kind_of Binding
    end
  end
end
