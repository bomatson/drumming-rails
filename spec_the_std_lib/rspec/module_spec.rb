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
      context 'given a module with a constant and instance methods' do
        let!(:subclass) { class Games < Module ; end }
        Battles = Module.new

        module War
          include Battles

          ARMY = 1

          def begin
            puts 'war started!'
          end
        end


        it '< will return true if module is subclass of other' do
          expect(
            Games < Module
          ).to be_true
        end

        it '< will return nil if there is no relationship between the two' do
          expect(
            War < Module
          ).to be_nil
        end

        it '<= will return true if module is the same as other' do
          expect(
            War <= War
          ).to be_true
        end

        it '<=> returns 1 if the first module is included in the second' do
          expect(
            Battles <=> War
          ).to eq 1
        end

        it '== returns true if obj and other are same object' do
          expect(
            Battles == Battles
          ).to be_true
        end

        it '> will return true if module is ancestor of other' do
          expect(
            Module > Games
          ).to be_true
        end

        it '>= will return true if module is the same as other' do
          expect(
            War >= War
          ).to be_true
        end

        it 'ancestors returns a array of modules included in the main module' do
          expect(War.ancestors).to eq [War, Battles]
        end
      end
    end
  end
end
