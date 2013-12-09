require 'rspec'

describe Integer do
  context 'public .instance methods' do

    it '#ceil returns the receiver' do
      expect(12.ceil).to eq 12
    end

    it '#chr defaults to ASCII encoding' do
      expect(255.chr.encoding).to eq Encoding::ASCII_8BIT
    end

    it '#chr with encoding provides a string containing char of receiver\'s value' do
      expect(255.chr(Encoding::UTF_8)).to eq "\303\277"
    end

    it '#denominator will always return a value of 1' do
      expect(12.denominator).to eq 1
    end

    it '#downto with a block passes decreasing values from int including limit' do
      expect(
        [].tap { |out| 5.downto(2) { |i| out << i } }
      ).to eq [5, 4, 3, 2]
    end

    it '#downto without a block returns an enumerator' do
      expect(5.downto(2)).to be_kind_of Enumerator
    end
  end
end
