module RSpec
  module Core
    module MemoizedHelpers
      module ClassMethods
        def string(*names)
          __each_if_method_not_defined(names) do |name|
            let(name) { "test-#{name}" }
          end
        end

        def create_params(*array)
          __each_if_method_not_defined(array) do |val|
            let(val) { "test-#{val}" }
          end
          let(:params) {
            array.each_with_object({}) do |elem, acc|
              acc[elem] = send(elem) if send(elem).present?
            end
          }
        end

        private

        def __each_if_method_not_defined(names)
          names.each do |name|
            yield(name) unless __lib_method_defined?(name)
          end
        end

        def __lib_method_defined?(name)
          RSpec::Core::MemoizedHelpers.module_for(self).method_defined?(name)
        end
      end
    end
  end
end
