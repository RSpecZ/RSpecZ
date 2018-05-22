module RSpec
  module Core
    module MemoizedHelpers
      module ClassMethods
        # TODO: あとで綺麗にリファクタリングする
        # TODO: contexts のときに配列が空だったらエラーが出るようにする

        def nil_context(name, description = nil, &block)
          context description || "when #{name} is nil" do
            let(name) { nil }
            instance_exec(name, &block)
          end
        end

        def nil_contexts(*names, &block)
          names.each do |name|
            nil_context(name, &block)
          end
        end

        def value_context(name, value, &block)
          context "when #{name} is #{value}" do
            let(name) { value }
            instance_eval(&block)
          end
        end

        def value_contexts(name, *values, &block)
          values.each do |value|
            value_context(name, value, &block)
          end
        end

        def invalid_context(name, value = 'invalid-value', &block)
          context "when #{name} is not valid(#{value})" do
            let(name) { value }
            instance_eval(&block)
          end
        end

        def invalid_contexts(name, *values, &block)
          values.each do |value|
            invalid_context(name, value, &block)
          end
        end

        def block_context(name, &block)
          continue_object = { name: name, block: block, myobject: self }
          def continue_object.spec(&block)
            continue_object = self
            self[:myobject].context "when #{self[:name]} is different" do
              let(continue_object[:name]) { instance_eval(&continue_object[:block]) }
              instance_eval(&block)
            end
          end
          continue_object
        end

        def nonexist_context(name, value, &block)
          context "when #{name} is not exist(#{value})" do
            let(name) { value }
            instance_eval(&block)
          end
        end

        def with_context(name, &block)
          context "when include context(#{name})" do
            include_context name
            instance_eval(&block)
          end
        end

        def array_contexts(*array, &block)
          array.each do |val|
            context "with #{val}" do
              instance_exec val, &block
            end
          end
        end
      end
    end
  end
end
