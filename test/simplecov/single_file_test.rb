# frozen_string_literal: true

require 'test_helper'

module SimpleCov
  class SingleFileTest < Test::Unit::TestCase
    test 'VERSION' do
      assert do
        ::SimpleCov::SingleFile.const_defined?(:VERSION)
      end
    end
  end
end
