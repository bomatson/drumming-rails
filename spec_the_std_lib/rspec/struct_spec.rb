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
end
