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

    it '#even? returns true if int is even' do
      expect(6.even?).to be_true
    end

    it '#floor returns the receiver as int is already Integer' do
      expect(5.floor).to eq 5
    end

    it '#gcd with another int provides greatest common divisor' do
      expect(6.gcd(18)).to eq 6
    end

    it '#gcdlcm provides array with [gcd, least common multiple]' do
      expect(6.gcdlcm(18)).to eq [6, 18]
    end
  end
end
