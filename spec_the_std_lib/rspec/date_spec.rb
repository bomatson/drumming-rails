require 'rspec'

describe Date do
  context 'public .class methods' do
    context ' object creation' do
      it '.new provides an instance of Date' do
        expect(Date.new).to be_instance_of Date
      end

      it '.new with no args defaults to 4712 BCE' do
        expect(Date.new.to_s).to eq '-4712-01-01'
      end

      it '.new with a year defaults to first day of calendar year' do
        expect(Date.new(2001).to_s).to eq '2001-01-01'
      end
    end
  end
end
