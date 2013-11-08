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
    it '=== invokes the block with object as proc\'s parameter like call' do
    end
  end
end
