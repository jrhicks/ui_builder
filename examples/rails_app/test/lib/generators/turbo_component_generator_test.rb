require "test_helper"
require "generators/turbo_component/turbo_component_generator"

class BaseUIBuilderGeneratorTest < Rails::Generators::TestCase
  tests BaseUIBuilderGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
