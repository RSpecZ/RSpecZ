module RSpec
  module Core
    class ExampleGroup
      # it_behaves_like => behave
      define_nested_shared_group_method :behave
    end
  end
end
