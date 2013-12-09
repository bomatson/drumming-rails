require 'rspec'

describe Integer do
  context 'public .instance methods' do
    let(:ascii_char) { ?\xFF }

    it '#ceil returns the receiver' do
      expect(12.ceil).to eq 12
    end

    it '#chr defaults to ASCII encoding' do
      expect(255.chr.encoding).to eq Encoding::ASCII_8BIT
    end

    it '#chr with encoding provides a string containing char of receiver\'s value' do
      expect(255.chr(Encoding::UTF_8)).to eq "\303\277"
    end
  end
end
