require 'rspec'

describe Date do
  context 'public .class methods' do
    context ' object creation' do
      context 'with .new' do
        it '.new provides an instance of Date' do
          expect(Date.new).to be_instance_of Date
        end

        it '.new with no args defaults to 4712 BCE' do
          expect(Date.new.to_s).to eq '-4712-01-01'
        end

        it '.new with a year defaults to first day of calendar year' do
          expect(Date.new(2001).to_s).to eq '2001-01-01'
        end

        it '.new with a year, month and day provides that exact date' do
          expect(Date.new(2013, 12, 19).to_s).to eq '2013-12-19'
        end

        it '.new with a negative month treats is as absolute number' do
          expect(Date.new(2013, -1, 19).to_s).to eq '2013-12-19'
        end

        it '.new with a negative day treats is as absolute number' do
          expect(Date.new(2013, 12, -1).to_s).to eq '2013-12-31'
        end

        it '.new with a 0 month raises an Argument error' do
          expect{ Date.new(2013, 0, 19).to_s }.to raise_error(ArgumentError)
        end

        it '.new with a 0 day raises an Argument error' do
          expect{ Date.new(2013, 1, 0).to_s }.to raise_error(ArgumentError)
        end
      end

      context 'with .jd' do
        it 'takes a chronological julian number, returning a date' do
          expect(Date.jd(2342837).to_s).to eq '1702-05-15'
        end

        it 'without an argument defaults to the first day of the julian calendar' do
          expect(Date.jd.to_s).to eq '-4712-01-01'
        end
      end
    end
  end
end
