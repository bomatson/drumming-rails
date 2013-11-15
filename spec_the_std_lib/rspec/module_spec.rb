describe Module do
  describe 'public .class methods' do
    it '.constants returns array of all constants accessible' do
      expect(Module.constants.first).to eq :Object
    end

    context 'given nested modules' do
      module First
        module Second
          $nesting = Module.nesting
        end
      end

      it '.nesting returns list of Modules nested at point of call' do
        expect($nesting).to eq [First::Second, First]
      end
    end

    context 'given an anonymous module' do
      let(:anonymous) do
        Module.new do
          def greet
            'hi there'
          end
        end
      end
      let(:string_wants_methods) { 'hi' }

      before { string_wants_methods.extend(anonymous) }

      it 'can be created with .new' do
        expect(anonymous).to be_kind_of Module
      end

      it 'can be extended for use on other objects' do
        expect(string_wants_methods.greet).to eq 'hi there'
      end
    end

    describe 'public #instance methods' do
      context 'given a Module with a constant and instance methods' do
        module War
          ARMY = 1

          def begin
            puts 'war started!'
          end
        end
      end
    end
  end
end
