module RSpec
  module Core
    module MemoizedHelpers
      module ClassMethods
        def subject_freezed(&block)
          if RSpec::Core::MemoizedHelpers.module_for(self).method_defined?('now')
            before(:each) { instance_eval { travel_to(now) } }
            after(:each) { instance_eval { travel_back } }
            subject(&block)
          else
            subject { raise RuntimeError.new('subject_freezed need you to define let(:now). Please define let(:now)') }
          end
        end
      end
    end
  end
end
