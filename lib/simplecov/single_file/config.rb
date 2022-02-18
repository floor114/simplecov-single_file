# frozen_string_literal: true

module SimpleCov
  module SingleFile
    class Config
      COLOR_RED = "\e[31m%<message>s\e[0m"
      COLOR_GREEN = "\e[32m%<message>s\e[0m"
      COLOR_ORANGE = "\e[33m%<message>s\e[0m"

      attr_accessor :output_colorized,
                    :output_style,
                    :output_green_threshold,
                    :output_orange_threshold,
                    :output_red_color,
                    :output_green_color,
                    :output_orange_color

      def initialize
        @output_colorized = true
        @output_red_color = COLOR_RED
        @output_green_color = COLOR_GREEN
        @output_orange_color = COLOR_ORANGE
      end
    end
  end
end
