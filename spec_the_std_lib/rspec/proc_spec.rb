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
  end
end
