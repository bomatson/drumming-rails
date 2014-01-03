require 'rspec'

describe Date do
  context 'public .class methods' do
    context ' object creation' do
      context 'with .new' do
        it 'provides an instance of Date' do
          expect(Date.new).to be_instance_of Date
        end

        it 'given no args defaults to 4712 BCE' do
          expect(Date.new.to_s).to eq '-4712-01-01'
        end

        it 'given a year defaults to first day of calendar year' do
          expect(Date.new(2001).to_s).to eq '2001-01-01'
        end

        it 'given a year, month and day provides that exact date' do
          expect(Date.new(2013, 12, 19).to_s).to eq '2013-12-19'
        end

        it 'given a negative month treats is as absolute number' do
          expect(Date.new(2013, -1, 19).to_s).to eq '2013-12-19'
        end

        it 'given a negative day treats is as absolute number' do
          expect(Date.new(2013, 12, -1).to_s).to eq '2013-12-31'
        end

        it 'given a 0 month raises an Argument error' do
          expect{ Date.new(2013, 0, 19) }.to raise_error(ArgumentError)
        end

        it 'given a 0 day raises an Argument error' do
          expect{ Date.new(2013, 1, 0) }.to raise_error(ArgumentError)
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

      context 'with .ordinal' do
        it 'given no args defaults to 4712 BCE' do
          expect(Date.ordinal.to_s).to eq '-4712-01-01'
        end

        it 'given a year defaults to first day of calendar year' do
          expect(Date.ordinal(2001).to_s).to eq '2001-01-01'
        end

        it 'given a year and positive yearday provides that exact date' do
          expect(Date.ordinal(2001, 44).to_s).to eq '2001-02-13'
        end

        it 'given a year and negative yearday provides that exact date' do
          expect(Date.ordinal(2001, -1).to_s).to eq '2001-12-31'
        end

        it 'given a 0 yearday raises an Argument error' do
          expect{ Date.new(2000, 0) }.to raise_error(ArgumentError)
        end
      end

      context 'with .commercial' do
        it 'given no args defaults to 4712 BCE' do
          expect(Date.commercial.to_s).to eq '-4712-01-01'
        end

        it 'given a calendar week year defaults to first day of calendar year' do
          expect(Date.commercial(2001).to_s).to eq '2001-01-01'
        end

        it 'given a year defaults to the first week where that year has Thursday in the week' do
          expect(Date.commercial(2008).to_s).to eq '2007-12-31'
        end

        it 'given a week uses the Monday from that calendar week date' do
          expect(Date.commercial(2008, 3).to_s).to eq '2008-01-14'
        end

        it 'given a weekday uses the next day from that calendar week date' do
          expect(Date.commercial(2008, 3, 2).to_s).to eq '2008-01-15'
        end

        it 'given a 0 weekday raise an ArgumentError' do
          expect{ Date.commercial(2008, 3, 0).to_s }.to raise_error(ArgumentError)
        end
      end

      context 'by parsing' do
        let(:new_date) { '2001-01-10' }

        subject { Date.parse(new_date) }

        it 'transforms a string into a Date' do
          expect(subject).to be_instance_of Date
        end

        it 'provides the same date as the string' do
          expect(subject.to_s).to eq new_date
        end

        context 'with a string of only integers' do
          let(:new_date) { '20010110' }

          it 'provides the same date as the string' do
            expect(subject.to_s).to eq '2001-01-10'
          end
        end

        context 'with a written out month' do
          let(:new_date) { '10 Jan 2001' }

          it 'provides the same date as the string' do
            expect(subject.to_s).to eq '2001-01-10'
          end
        end
      end
    end
  end
end
