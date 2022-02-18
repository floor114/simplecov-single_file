# frozen_string_literal: true

require_relative 'single_file/output/block'
require_relative 'single_file/output/table'
require_relative 'single_file/config'
require_relative 'single_file/formatter'
require_relative 'single_file/version'

module SimpleCov
  module SingleFile
    class << self
      def config
        @config ||= Config.new
      end

      def configure
        yield(config)
      end
    end
  end
end
