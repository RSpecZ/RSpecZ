module RSpec
  module Core
    module MemoizedHelpers
      module ClassMethods
        def multi_behave(*examples)
          examples.each do |example|
            it_behaves_like example
          end
        end
      end
    end
  end
end
