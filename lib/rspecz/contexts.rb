module RSpec
  module Core
    module MemoizedHelpers
      module ClassMethods
        # TODO: あとで綺麗にリファクタリングする
        # TODO: contexts のときに配列が空だったらエラーが出るようにする

        def set_nil(name, description = nil, &block)
          context description || "when #{name} is nil" do
            let(name) { nil }
            instance_exec(name, &block)
          end
        end
        alias_method :nil_context, :set_nil

        def set_nils(*names, &block)
          names.each do |name|
            nil_context(name, &block)
          end
        end
        alias_method :nil_contexts, :set_nils

        def set(name, value, description = nil, &block)
          context description || "when #{name} is #{value}" do
            let(name) { value }
            instance_exec(name, value, &block)
          end
        end
        alias_method :value_context, :set

        def set_values(name, *values, &block)
          values.each do |value|
            value_context(name, value, &block)
          end
        end
        alias_method :value_contexts, :set_values

        def set_valid(name, value, description = nil, &block)
          context description || "when #{name} is valid(#{value})" do
            let(name) { value }
            instance_exec(name, value, &block)
          end
        end

        def set_invalid(name, value = 'invalid-value', description = nil, &block)
          context description || "when #{name} is not valid(#{value})" do
            let(name) { value }
            instance_exec(name, value, &block)
          end
        end
        alias_method :invalid_context, :set_invalid

        def set_invalids(name, *values, &block)
          values.each do |value|
            invalid_context(name, value, &block)
          end
        end
        alias_method :invalid_contexts, :set_invalids

        def set_block(name, description = nil, &block)
          continue_object = { name: name, descrioption: description, block: block, myobject: self }
          def continue_object.spec(&block)
            continue_object = self
            self[:myobject].context self[:description] || "when #{self[:name]} is different" do
              let(continue_object[:name]) { instance_eval(&continue_object[:block]) }
              instance_exec(name, &block)
            end
          end
          continue_object
        end
        alias_method :block_context, :set_block

        def set_missing(name, value = 'missing-value', description = nil, &block)
          context description || "when #{name} does not exist(#{value})" do
            let(name) { value }
            instance_exec(name, &block)
          end
        end
        alias_method :nonexist_context, :set_missing

        def set_context(name, &block)
          context "when include context(#{name})" do
            include_context name
            instance_eval(&block)
          end
        end
        alias_method :with_context, :set_context
      end
    end
  end
end
