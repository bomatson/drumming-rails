require 'rspec'

describe Struct do
  context 'public .class methods' do
    let(:my_struct) { Struct.new("Thing", :name) }

    it '.new without a symbol will raise ArgmentError' do
      expect{ Struct.new }.to raise_error(ArgumentError)
    end

    it '.new with a single symbol returns anoynmous Class object' do
      expect(Struct.new(:name)).to be_kind_of Class
    end

    it '.new with a string defines the name of the class' do
      expect(Struct.new("Loner")).to eq Struct::Loner
    end

    it '.new with string and symbol creates a parameter of Class' do
      expect(my_struct.method_defined?(:name)).to be_true
    end

    it '.new allows instance of Struct::Class' do
      expect(Struct::Thing.new("Bobby")).to be_instance_of Struct::Thing
    end

    it '.new can be named by a Constant' do
      expect(
        Person = Struct.new(:name)
      ).to eq Person
    end

    it '.new named by Constant allows instance of Class' do
      expect(Person.new("Roberto")).to be_instance_of Person
    end
  end

  context 'public instance methods' do
    before(:all) { Folk = Struct.new(:name) }
    let(:folk) { Folk.new('bob') }

    it '== returns true if other_struct has same values of all instance variables' do
      expect(
        folk == Folk.new('bob')
      ).to be_true
    end

    it '[:symbol] reference returns value of instance var' do
      expect(folk[:name]).to eq 'bob'
    end

    it '[symbol] reference that dne raises NameError' do
      expect{ folk[:booga] }.to raise_error(NameError)
    end

    it '[index] reference returns value of instance var' do
      expect(folk[0]).to eq 'bob'
    end

    it '[index] reference that dne raises IndexError' do
      expect{ folk[1] }.to raise_error(IndexError)
    end

    it '[:symbol]= assigns attribute to variable' do
      folk[:name] = 'sandy'
      expect(folk.name).to eq 'sandy'
    end

    it '[index]= assigns attribute to variable' do
      folk[0] = 'sandy'
      expect(folk.name).to eq 'sandy'
    end
  end
end
