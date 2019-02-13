module RSpecZ
  METADATA_WITH_COUNT = :___rspecz_with_count
  METADATA_SO_COUNT = :___rspecz_so_count

  class << self
    def describe(*args, &example_group_block)
      RSpec.describe(*args, &example_group_block).tap do |result|
        if result.metadata[RSpecZ::METADATA_WITH_COUNT] != result.metadata[RSpecZ::METADATA_SO_COUNT]
          raise RuntimeError.new('You have some .with method without .so method. You may miss .so method in your code.')
        end
      end
    end
  end
end
