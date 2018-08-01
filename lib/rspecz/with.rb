module RSpec
  module Core
    module MemoizedHelpers
      module ClassMethods
        class WithContext
          attr_accessor :name, :values, :description, :block, :myobject

          def initialize(name, values, block, myobject)
            @name, @values, @block, @myobject = name, values, block, myobject
          end

          def desc(description)
            @description = description
            self
          end

          def so(&block)
            continue_object = self
            continue_object_block = @block
            # TODO: create description from block.source
            if @values.length > 0
              raise RuntimeError.new("Syntax error you cannot set description by 'desc' method when you have multiple values set.") if @values.length > 1 && @description
              @values.each do |value|
                @myobject.context "when #{@name} is #{value}" do
                  let(continue_object.name) { value }
                  instance_exec(value, &block)
                end
              end
            else
              @myobject.context @description || "when #{@name} is different" do
                if continue_object.name
                  let(continue_object.name) { instance_eval(&continue_object_block) }
                else
                  before { instance_eval(&continue_object_block) }
                end
                instance_exec(&block)
              end
            end
          end
        end

        def with(name = nil, *values, &block)
          WithContext.new(name, values, block, self)
        end
      end
    end
  end
end
